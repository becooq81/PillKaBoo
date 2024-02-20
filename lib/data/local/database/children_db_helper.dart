import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class ChildrenDBHelper {
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
    String dbPath = join(path, 'children.db');
    // Open the database and create the table if it doesn't exist
    return await openDatabase(dbPath, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE IF NOT EXISTS children_table (품목일련번호 TEXT, combined TEXT)',
      );
      await db.execute(
        'CREATE INDEX IF NOT EXISTS idx_품목일련번호 ON children_table (품목일련번호);',
      );
    });
  }
  static Future<void> loadCsvData(Database db) async {
    final String csvData = await rootBundle.loadString(
        'assets/pdfs/children.csv');
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(csvData);
    Batch batch = db.batch();
    for (var row in csvTable.skip(1)) { // Assuming the first row is headers
      batch.insert('children_table', {
        '품목일련번호': row[0].toString(),
        'combined': row[1].toString()
      });
    }
    await batch.commit(noResult: true);
  }
  static Future<List<Map<String, dynamic>>> searchChildByItemCode(String itemCode) async {
    itemCode = itemCode.trim();
    final Database db = await database;
    final List<Map<String, dynamic>> matches = await db.query(
      'children_table',
      where: '품목일련번호 = ?',
      whereArgs: [itemCode],
    );
    return matches;
  }
}