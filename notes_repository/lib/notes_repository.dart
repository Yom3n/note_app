library notes_repository;

import 'package:notes_database/notes_database.dart';
import 'package:notes_database/models/note_entity.dart';

class NotesRepository {
  final NotesDatabase database;

  NotesRepository(this.database);

  Future<NoteEntity?> getNoteById(int id) {
    return database.getNote(id);
  }

  Future<List<NoteEntity>> getNotes() {
    return database.getNotes();
  }

  Future<NoteEntity> createNote(NoteEntity input) async {
    return database.createNote(input);
  }

  Future<NoteEntity?> updateNote(NoteEntity input) async {
    assert(input.id != null);
    final wasEntityUpdated = await database.updateNote(input);
    if (wasEntityUpdated) {
      return database.getNote(input.id!);
    }
    return null;
  }

  Future<NoteEntity?> archiveNote(int noteId) async {
    final noteToUpdate = await database.getNote(noteId);
    if (noteToUpdate == null) {
      // TODO Throw
    }
    noteToUpdate?.state = 3;
    final wasEntityUpdated = await database.updateNote(noteToUpdate!);
    if (wasEntityUpdated) {
      return database.getNote(noteId);
    }
    return null;
  }
}
