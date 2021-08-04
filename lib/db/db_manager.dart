import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import '../models/journal_entry.dart';

class DatabaseManager {
  static const String DATABASE_FILENAME = 'journal.sqlite3.db';
  static const String CREATE_FILE = 'assets/schema_1.sql.txt';
  static const String SQL_SELECT = 'SELECT * FROM journal_entries';
  static const String SQL_INSERT = 'INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?);';
  

  static late final DatabaseManager _instance;
  late final Database db;

  DatabaseManager._({required Database database}) : db = database;

  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize() async {
    String createSchema = await readQuery();

    final db = await openDatabase(DATABASE_FILENAME,
      version: 1,
      onCreate: (Database db, int version) async {
        createTables(db, createSchema);
      }
    );
    _instance = DatabaseManager._(database: db);
  }

  static Future<String> readQuery() async {
    return await rootBundle.loadString(CREATE_FILE);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  void saveJournalEntry({entry}) {
    db.transaction((tra) async{
      await tra.rawInsert(SQL_INSERT,
        [entry.title, entry.body, entry.rating, entry.date]);
    });
  }

  Future <List<JournalEntry>> entries() async {
    final journalEntriesRaw = await db.rawQuery(SQL_SELECT);
    List<JournalEntry> journalEntries = journalEntriesRaw.map( (record) {
      return JournalEntry(
        title: record['title'] as String,
        body: record['body'] as String,
        rating: record['rating'] as int,
        date: record['date'] as String
      );
    }).toList();

    return journalEntries;
  }
}