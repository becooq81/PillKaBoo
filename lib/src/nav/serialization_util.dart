import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

import '../core/lat_lng.dart';
import '../core/place.dart';
import '../core/uploaded_file.dart';

/// SERIALIZATION HELPERS

String dateTimeRangeToString(DateTimeRange dateTimeRange) {
  final startStr = dateTimeRange.start.millisecondsSinceEpoch.toString();
  final endStr = dateTimeRange.end.millisecondsSinceEpoch.toString();
  return '$startStr|$endStr';
}

String placeToString(PKBPlace place) => jsonEncode({
      'latLng': place.latLng.serialize(),
      'name': place.name,
      'address': place.address,
      'city': place.city,
      'state': place.state,
      'country': place.country,
      'zipCode': place.zipCode,
    });

String uploadedFileToString(PKBUploadedFile uploadedFile) =>
    uploadedFile.serialize();

String? serializeParam(
    dynamic param,
    ParamType paramType, [
      bool isList = false,
    ]) {
  try {
    if (param == null) {
      return null;
    }
    if (isList) {
      final serializedValues = (param as Iterable)
          .map((p) => serializeParam(p, paramType, false))
          .where((p) => p != null)
          .map((p) => p!)
          .toList();
      return json.encode(serializedValues);
    }
    switch (paramType) {
      case ParamType.integer:
        return param.toString();
      case ParamType.doubleType:
        return param.toString();
      case ParamType.stringType:
        return param;
      case ParamType.boolean:
        return param ? 'true' : 'false';
      case ParamType.dateTime:
        return (param as DateTime).millisecondsSinceEpoch.toString();
      case ParamType.dateTimeRange:
        return dateTimeRangeToString(param as DateTimeRange);
      case ParamType.latLng:
        return (param as LatLng).serialize();
      case ParamType.color:
        return (param as Color).toCssString();
      case ParamType.pkbPlace:
        return placeToString(param as PKBPlace);
      case ParamType.pkbUploadedFile:
        return uploadedFileToString(param as PKBUploadedFile);
      case ParamType.json:
        return json.encode(param);

      default:
        return null;
    }
  } catch (e) {
    return null;
  }
}


/// END SERIALIZATION HELPERS

/// DESERIALIZATION HELPERS

DateTimeRange? dateTimeRangeFromString(String dateTimeRangeStr) {
  final pieces = dateTimeRangeStr.split('|');
  if (pieces.length != 2) {
    return null;
  }
  return DateTimeRange(
    start: DateTime.fromMillisecondsSinceEpoch(int.parse(pieces.first)),
    end: DateTime.fromMillisecondsSinceEpoch(int.parse(pieces.last)),
  );
}

LatLng? latLngFromString(String latLngStr) {
  final pieces = latLngStr.split(',');
  if (pieces.length != 2) {
    return null;
  }
  return LatLng(
    double.parse(pieces.first.trim()),
    double.parse(pieces.last.trim()),
  );
}

PKBPlace placeFromString(String placeStr) {
  final serializedData = jsonDecode(placeStr) as Map<String, dynamic>;
  final data = {
    'latLng': serializedData.containsKey('latLng')
        ? latLngFromString(serializedData['latLng'] as String)
        : const LatLng(0.0, 0.0),
    'name': serializedData['name'] ?? '',
    'address': serializedData['address'] ?? '',
    'city': serializedData['city'] ?? '',
    'state': serializedData['state'] ?? '',
    'country': serializedData['country'] ?? '',
    'zipCode': serializedData['zipCode'] ?? '',
  };
  return PKBPlace(
    latLng: data['latLng'] as LatLng,
    name: data['name'] as String,
    address: data['address'] as String,
    city: data['city'] as String,
    state: data['state'] as String,
    country: data['country'] as String,
    zipCode: data['zipCode'] as String,
  );
}

PKBUploadedFile uploadedFileFromString(String uploadedFileStr) =>
    PKBUploadedFile.deserialize(uploadedFileStr);

enum ParamType {
  integer,
  doubleType,
  stringType,
  boolean,
  dateTime,
  dateTimeRange,
  latLng,
  color,
  pkbPlace,
  pkbUploadedFile,
  json,
}

dynamic deserializeParam<T>(
  String? param,
  ParamType paramType,
  bool isList,
) {
  try {
    if (param == null) {
      return null;
    }
    if (isList) {
      final paramValues = json.decode(param);
      if (paramValues is! Iterable || paramValues.isEmpty) {
        return null;
      }
      return paramValues
          .whereType<String>()
          .map((p) => p)
          .map((p) => deserializeParam<T>(p, paramType, false))
          .where((p) => p != null)
          .map((p) => p! as T)
          .toList();
    }
    switch (paramType) {
      case ParamType.integer:
        return int.tryParse(param);
      case ParamType.doubleType:
        return double.tryParse(param);
      case ParamType.stringType:
        return param;
      case ParamType.boolean:
        return param == 'true';
      case ParamType.dateTime:
        final milliseconds = int.tryParse(param);
        return milliseconds != null
            ? DateTime.fromMillisecondsSinceEpoch(milliseconds)
            : null;
      case ParamType.dateTimeRange:
        return dateTimeRangeFromString(param);
      case ParamType.latLng:
        return latLngFromString(param);
      case ParamType.color:
        return fromCssColor(param);
      case ParamType.pkbPlace:
        return placeFromString(param);
      case ParamType.pkbUploadedFile:
        return uploadedFileFromString(param);
      case ParamType.json:
        return json.decode(param);

      default:
        return null;
    }
  } catch (e) {
    return null;
  }
}