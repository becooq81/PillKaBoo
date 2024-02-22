import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class BarcodeDBHelper {
  static Database? _db;
  static Future<Database> get database async {
    if (_db == null) {
      _db = await initializeDB();
      await loadCsvData(_db!);
    }
    return _db!;
  }
  static Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, 'barcodes.db');
    return await openDatabase(dbPath, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE IF NOT EXISTS barcodes_table (한글상품명 TEXT, 품목기준코드 TEXT, 표준코드 TEXT)',
      );
      await db.execute(
        'CREATE INDEX IF NOT EXISTS idx_표준코드 ON barcodes_table (표준코드);',
      );
    });
  }
  static Future<void> loadCsvData(Database db) async {
    final String csvData = await rootBundle.loadString(
        'assets/data/barcodes.csv');
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(csvData);
    Batch batch = db.batch();
    for (var row in csvTable.skip(1)) {
      batch.insert('barcodes_table', {
        '한글상품명': row[0].toString(),
        '품목기준코드': row[1].toString(),
        '표준코드': row[2].toString(),
      });
    }
    await batch.commit(noResult: true);
  }
  static Future<List<Map<String, dynamic>>> searchByBarcode(String inputBarcode) async {
    inputBarcode = inputBarcode.trim();

    final int firstEightIndex = inputBarcode.indexOf('8');
    if (firstEightIndex != -1) {
      inputBarcode = inputBarcode.substring(firstEightIndex);
    }

    final Database db = await database;
    final List<Map<String, dynamic>> matches = await db.query(
      'barcodes_table',
      where: '표준코드 = ?',
      whereArgs: [inputBarcode],
    );
    return matches;
  }
}