library notes_database;

import 'package:notes_database/models/note_entity.dart';
import 'package:sqflite/sqflite.dart' as sql;

const String TABLE_NAME = 'Notes';

class NotesDatabase {
  sql.Database? _db;

  NotesDatabase();

  Future<void> openDatabase() async {
    _db = await sql.openDatabase('notes_db.db', version: 1,
        onCreate: (sql.Database db, int version) async {
      await db.execute(
        _getCreateDatabaseSql(),
      );
    });
  }

  Future<NoteEntity> createNote(NoteEntity noteEntity) async {
    await _openDbIfNeeded();
    final id = await _db!.insert(TABLE_NAME, noteEntity.toMap());
    return noteEntity..id = id;
  }

  Future<List<NoteEntity>> getNotes() async {
    await _openDbIfNeeded();
    List<Map<String, Object?>> maps = await _db!.query(
      TABLE_NAME,
      columns: ['id', 'name', 'date', 'body', 'state'],
      // where: '$columnId = ?',
      // whereArgs: [id]);
    );
    if (maps.isNotEmpty) {
      return maps.map((m) => NoteEntity.fromMap(m)).toList();
    }
    return [];
  }

  Future<NoteEntity?> getNote(int id) async {
    await _openDbIfNeeded();
    List<Map<String, Object?>> maps = await _db!.query(TABLE_NAME,
        columns: ['id', 'name', 'date', 'body', 'state'],
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return NoteEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<bool> updateNote(NoteEntity note) async {
    await _openDbIfNeeded();
    final changedRows = await _db!.update(TABLE_NAME, note.toMap(),
        where: 'id = ?', whereArgs: [note.id]);
    return changedRows == 1;
  }

  Future<bool> archiveNote(int id) async {
    await _openDbIfNeeded();
    final noteToArchive = await getNote(id);
    if (noteToArchive == null) {
      throw Exception('Note with id $id does not exist');
    } else {
      return updateNote(noteToArchive..state = 2);
    }
  }

  String _getCreateDatabaseSql() => '''CREATE TABLE $TABLE_NAME 
      (id INTEGER PRIMARY KEY NOT NULL,
       name TEXT NOT NULL,
       date DATE NOT NULL,
       body TEXT,
       state INTEGER NOT NULL
     )''';

  Future<void> _openDbIfNeeded() async {
    if (_db == null || !_db!.isOpen) {
      await openDatabase();
    }
  }
}
