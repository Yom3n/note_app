library notes_database;

import 'package:notes_database/models/note_entity.dart';
import 'package:sqflite/sqflite.dart' as sql;

const String TABLE_NAME = 'Notes';

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

  Future<NoteEntity> createNote(NoteEntity noteEntity) async {
    _assertDbInitialized();
    final id = await _db!.insert(TABLE_NAME, noteEntity.toMap());
    return noteEntity..id = id;
  }

  Future<List<NoteEntity>> getNotes() async {
    _assertDbInitialized();
    List<Map<String, Object?>> maps = await _db!.query(
      TABLE_NAME,
      columns: ['name', 'date', 'body', 'state'],
      // where: '$columnId = ?',
      // whereArgs: [id]);
    );
    if (maps.isNotEmpty) {
      return maps.map((m) => NoteEntity.fromMap(m)).toList();
    }
    return [];
  }

  Future<NoteEntity?> getNote(int id) async {
    _assertDbInitialized();
    List<Map<String, Object?>> maps = await _db!.query(TABLE_NAME,
        columns: ['name', 'date', 'body', 'state'],
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return NoteEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateNote(NoteEntity note) async {
    _assertDbInitialized();
    return await _db!.update(TABLE_NAME, note.toMap(),
        where: 'id = ?', whereArgs: [note.id]);
  }

  Future<int> archiveNote(int id) async {
    final noteToArchive = await getNote(id);
    if (noteToArchive == null) {
      throw Exception('Note with id $id does not exist');
    } else {
      final updatedNote = await updateNote(noteToArchive..state = 2);
      return updatedNote;
    }
  }

  Future<void> close() async {
    if (_db != null) {
      _db!.close();
    }
  }

  String _getCreateDatabaseSql() => '''CREATE TABLE $TABLE_NAME 
      (id INTEGER PRIMARY KEY NOT NULL,
       name TEXT NOT NULL,
       date DATE NOT NULL,
       body TEXT,
       state INTEGER NOT NULL
     )''';

  void _assertDbInitialized() {
    assert(_db != null, 'Call openDatabase first');
  }
}
