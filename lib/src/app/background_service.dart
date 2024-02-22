import '../network/connectivity.dart';
import '../network/download_file.dart';
import '../data/local/database/processed_file_db_helper.dart';

// Check if wifi is available and download new data
Future<void> checkAndUpdateData() async {
  if (await isWifiConnected()) {
    //print('Connected to Wi-Fi.');
    if (await shouldDownloadNewData()) {
      //print('Downloading new CSV data...');
      try {
        final url = 'https://us-central1-pill-412920.cloudfunctions.net/go-http-function';
        String data = await downloadFile(url);
        await ProcessedFileDBHelper.replaceDatabaseWithSQL(data);
      } catch (e) {
        //print('Error updating CSV data: $e');
      }
    } else {
      //print('CSV data is up to date.');
    }
  } else {
    //print('Not connected to Wi-Fi.');
  }
}
