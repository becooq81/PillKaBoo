import 'package:http/http.dart' as http;
import 'dart:io';
import 'connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

Future<String> downloadFile(String url) async {
  if (await isWifiConnected()) {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Directory tempDir = await getTemporaryDirectory();
        String filePath = '${tempDir.path}/output.db';
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        updateLastDownloadTime();
        return filePath;
      } else {
        throw const HttpException('Failed to download file');
      }
    } catch (e) {
      print('An error occurred: $e');
      return '';
    }

  } else {
    print("No wifi");
    return ''; // Return an empty list when no Wi-Fi is connected.
  }
}

Future<void> updateLastDownloadTime() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('lastDownload', DateTime.now().millisecondsSinceEpoch);
}

Future<bool> shouldDownloadNewData() async {
  final prefs = await SharedPreferences.getInstance();
  int? lastDownload = prefs.getInt('lastDownload');
  print("Last download: $lastDownload");
  if (lastDownload == null) {
    return true; // No previous download found
  }

  final lastDownloadDate = DateTime.fromMillisecondsSinceEpoch(lastDownload);
  print('Last download: $lastDownloadDate');
  final oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));
  return lastDownloadDate.isBefore(oneWeekAgo);
}
