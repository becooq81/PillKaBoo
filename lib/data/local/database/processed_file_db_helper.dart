import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';


class ProcessedFileDBHelper {
  static Database? _db;

  static Future<Database> get database async {
    _db ??= await initializeDB();
    return _db!;
  }

  static Future<List<String>> getColumnAsListOfStrings(String columnName) async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('med_table');
    List<String> columnList = maps.map((row) => row[columnName].toString()).toList();
    return columnList;
  }

  static Future<Database> initializeDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'processed_file.db');
    await copyDatabaseFromAssets(path, 'assets/data/processed_file.db');
    // Open the database
    Database db = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        // Create tables and indexes if they don't exist - example:
        // await db.execute('CREATE TABLE IF NOT EXISTS your_table_name (...);');
      },
    );
    // Ensure the index on itemSeq column exists
    await db.execute('CREATE INDEX IF NOT EXISTS idx_itemSeq ON med_table (itemSeq);');
    return db;
  }
  static Future<void> copyDatabaseFromAssets(String dbPath, String assetPath) async {
    final exists = await databaseExists(dbPath);
    if (!exists) {
      try {
        await Directory(dirname(dbPath)).create(recursive: true);
        ByteData data = await rootBundle.load(assetPath);
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(dbPath).writeAsBytes(bytes, flush: true);
      } catch (e) {
        print("Error copying database from assets: $e");
      }
    }
  }
  static Future<void> replaceDatabaseWithSQL(String sqlContent) async {
    final dbPath = await getDatabasesPath();
    final databasePath = join(dbPath, 'processed_file.db');
    // Close the existing database if open
    if (_db != null && _db!.isOpen) {
      await _db!.close();
      _db = null;
    }
    // Delete the existing database file
    try {
      await File(databasePath).delete();
    } catch (e) {
      print("Error deleting existing database file: $e");
    }
    // Create a new database with the same schema
    _db = await initializeDB();
    // Split the SQL content into individual statements and execute them
    try {
      final batch = _db!.batch();
      final sqlStatements = sqlContent.split(';');
      for (final statement in sqlStatements) {
        final trimmedStatement = statement.trim();
        if (trimmedStatement.isNotEmpty) {
          batch.rawInsert(trimmedStatement);
        }
      }
      await batch.commit(noResult: true);
      print("Database replaced successfully");
    } catch (e) {
      print("Error replacing database: $e");
    }
  }
  static Future<List<Map<String, dynamic>>> searchByItemSeq(String inputSeq) async {
    final Database db = await ProcessedFileDBHelper.database;
    final List<Map<String, dynamic>> matches = await db.query(
      'med_table',
      where: 'itemSeq = ?',
      whereArgs: [inputSeq],
    );
    return matches;
  }
  static Future<List<Map<String, dynamic>>> searchByItemName(String inputName) async {
    print("searchByItemName: $inputName");
    final Database db = await ProcessedFileDBHelper.database;
    final itemColumn = await getColumnAsListOfStrings("itemName");
    String identified = "";

    for (String item in itemColumn) {
      // Calculate the similarity score
      int score = tokenSetPartialRatio(item, inputName);
      // If the score is higher than the threshold, add the item to the list
      if (score > 95) {
        identified = item;
      }
    }
    final List<Map<String, dynamic>> matches = await db.query(
      'med_table',
      where: 'itemName = ?',
      whereArgs: [identified],
    );
    return matches;
  }
}