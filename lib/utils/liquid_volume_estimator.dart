import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:core';

import 'package:matrix2d/matrix2d.dart';

import 'package:flutter_vision/flutter_vision.dart';

class BytesImage {
  Uint8List bytes;
  int height;
  int width;
  BytesImage(this.bytes, this.height, this.width);
}

class BoxCoords {
  int x0;
  int y0;
  int x1;
  int y1;
  BoxCoords(this.x0, this.y0, this.x1, this.y1);
  BoxCoords.fromList(List<int> list)
      : x0 = list[0],
        y0 = list[1],
        x1 = list[2],
        y1 = list[3];
}

Future<BytesImage> convXFile2BytesImage(XFile xFile) async {
  final bytes = await xFile.readAsBytes();
  final image = await decodeImageFromList(bytes);
  return BytesImage(bytes, image.height, image.width);
}

img.Image convBytesImage2imgImage(BytesImage bytesImage) {
  return img.Image.fromBytes(
      width: bytesImage.width,
      height: bytesImage.height,
      bytes: bytesImage.bytes.buffer);
}

BytesImage convImgImage2BytesImage(img.Image imgImage) {
  return BytesImage(imgImage.toUint8List(), imgImage.height, imgImage.width);
}

BytesImage cropBytesImage(BytesImage bytesImage, BoxCoords boxCoords) {
  final imgImage = convBytesImage2imgImage(bytesImage);
  final newWidth = boxCoords.x1 - boxCoords.x0;
  final newHeight = boxCoords.y1 - boxCoords.y0;
  final croppedImgImage = img.copyCrop(imgImage,
      x: boxCoords.x0, y: boxCoords.y0, width: newWidth, height: newHeight);
  return convImgImage2BytesImage(croppedImgImage);
}

List<List<int>> preprocess(BytesImage bytesImage,
    [int binarizeThreshold = 100]) {
  img.Image image = img.decodeJpg(bytesImage.bytes)!;
  Uint8List arrImage = image.getBytes(order: img.ChannelOrder.rgb);

  return arrImage
      .reshape(3, arrImage.length ~/ 3)
      .map((x) => (x[0] + x[1] + x[2]) / 3)
      .toList()
      .map((x) => x >= binarizeThreshold ? 1 : 0)
      .toList()
      .reshape(image.height, image.width) as List<List<int>>;
}

List<int> rowsum(List<List<int>> preprocessed) {
  return preprocessed.map((x) => x.reduce((a, b) => a + b)).toList();
}

int? getLiquidLevelFromRowsum(List<int> rsum, [int levelThreshold = 5]) {
  for (var entry in rsum.asMap().entries) {
    int i = entry.key;
    int v = entry.value;
    if (v < levelThreshold) {
      return i;
    }
  }
  return null;
}

int? getLiquidLevel(BytesImage image) {
  final preprocessed = preprocess(image);
  final rsum = rowsum(preprocessed);
  return getLiquidLevelFromRowsum(rsum);
}

InputImage convBytesImage2InputImage(BytesImage bytesImage) {
  return InputImage.fromBytes(
      bytes: bytesImage.bytes,
      metadata: InputImageMetadata(
          size: Size(bytesImage.width.toDouble(), bytesImage.height.toDouble()),
          rotation: InputImageRotation.rotation0deg,
          format: InputImageFormat.nv21,
          bytesPerRow: 0));
}

int estimateCC(List<int?> scalePositions, int liquidLevel) {
  int cc = 0;
  int min = 1000;
  for (var entry in scalePositions.asMap().entries) {
    int i = entry.key;
    int? s = entry.value;
    if (s != null) {
      final dd = (liquidLevel - s) * (liquidLevel - s);
      if (dd < min) {
        cc = i + 1;
        min = dd;
      }
    }
  }
  return cc;
}

class LiquidVolumeEstimator {
  FlutterVision vision;
  TextRecognizer textRecognizer;

  LiquidVolumeEstimator()
      : vision = FlutterVision(),
        textRecognizer = TextRecognizer(script: TextRecognitionScript.latin) {
    vision.loadYoloModel(
        labels: "assets/labels.txt",
        modelPath: "assets/yolov8n.tflite",
        modelVersion: "yolov8",
        quantization: false,
        numThreads: 1,
        useGpu: false);
  }

  void stop() {
    vision.closeYoloModel();
    textRecognizer.close();
  }

  Future<BoxCoords?> detectBottle(BytesImage bytesImage) async {
    final detectedObjects = await vision.yoloOnImage(
        bytesList: bytesImage.bytes,
        imageHeight: bytesImage.height,
        imageWidth: bytesImage.width);

    return detectedObjects.isEmpty
        ? null
        : BoxCoords.fromList(detectedObjects[0]["box"]);
  }

  Future<List<int?>> getScalePositions(BytesImage bytesImage) async {
    InputImage inputImage = convBytesImage2InputImage(bytesImage);
    List<int?> positions = List.filled(20, null);
    final text = await textRecognizer.processImage(inputImage);
    for (TextBlock block in text.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          final parsed = int.tryParse(element.text);
          if (parsed != null && parsed <= 20) {
            final y =
                (element.cornerPoints[0].y + element.boundingBox.center.dy)
                    .round();
            positions[parsed] = y;
          }
        }
      }
    }
    return positions;
  }

  Future<int?> call(XFile frame) async {
    final bytesImage = await convXFile2BytesImage(frame);

    final detectedBoxCoords = await detectBottle(bytesImage);
    if (detectedBoxCoords == null) {
      debugPrint("NO BOTTLE DETECTED");
      return null;
    }

    final croppedBytesImage = cropBytesImage(bytesImage, detectedBoxCoords);

    final scalePositions = getScalePositions(bytesImage);

    final liquidLevel = getLiquidLevel(croppedBytesImage);
    if (liquidLevel == null) {
      debugPrint("CANNOT FIND LIQUID SURFACE LINE");
      return null;
    }

    return estimateCC(await scalePositions, liquidLevel);
  }
}
