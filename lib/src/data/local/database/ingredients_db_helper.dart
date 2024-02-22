import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class IngredientsDBHelper {
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
    String dbPath = join(path, 'ingredients.db');
    return await openDatabase(dbPath, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE IF NOT EXISTS ingredients_table (품목일련번호 TEXT, 주성분 TEXT)',
      );
      await db.execute(
        'CREATE INDEX IF NOT EXISTS idx_품목일련번호 ON ingredients_table (품목일련번호);',
      );
    });
  }
  static Future<void> loadCsvData(Database db) async {
    final String csvData = await rootBundle.loadString(
        'assets/data/ingredients.csv');
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(csvData);
    Batch batch = db.batch();
    for (var row in csvTable.skip(1)) { 
      batch.insert('ingredients_table', {
        '품목일련번호': row[0].toString(),
        '주성분': row[1].toString(),
      });
    }
    await batch.commit(noResult: true);
  }
  static Future<List<Map<String, dynamic>>> searchIngredientsBySeqNum(String inputSeqNum) async {
    inputSeqNum = inputSeqNum.trim().toString();
    final Database db = await database;
    final List<Map<String, dynamic>> matches = await db.query(
      'ingredients_table',
      where: '품목일련번호 = ?',
      whereArgs: [inputSeqNum], 
    );
    return matches;
  }

  static Future<List<Map<String, dynamic>>> searchIngredientsByAllergies(List<String> userAllergies) async {
    final Database db = await database;
    final List<Map<String, dynamic>> matches = await db.query(
      'ingredients_table',
      where: '주성분 IN (${userAllergies.map((_) => '?').join(',')})',
      whereArgs: userAllergies,
    );
    return matches;
  }
}