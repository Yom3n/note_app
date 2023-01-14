library notes_database;

import 'package:sqflite/sqflite.dart' as sql;

class NotesDatabase {
  sql.Database? _db;

  Future<void> openDatabase() async {
    _db = await sql.openDatabase('notes_db.db', version: 1,
        onCreate: (sql.Database db, int version) async {
      await db.execute(
        _getCreateDatabaseSql(),
      );
    });
  }

  String _getCreateDatabaseSql() => '''CREATE TABLE Notes 
      (id INTEGER PRIMARY KEY NOT NULL,
       name TEXT NOT NULL,
       date DATE NOT NULL,
       body TEXT,
       state INTEGER NOT NULL
     )''';
}
