library notes_repository;

import 'package:notes_database/notes_database.dart';
import 'package:models/note.dart';
import 'package:notes_database/models/note_entity.dart';

class NotesRepository {
  final NotesDatabase database;

  NotesRepository(this.database);

  Future<Note?> getNoteById(int id) async {
    final noteEntity = await database.getNote(id);
    if (noteEntity != null) {
      return noteEntityToModel(noteEntity);
    }
    return null;
  }

  Future<List<Note>> getNotes() async {
    final notesEntities = await database.getNotes();
    return notesEntities.map((e) => noteEntityToModel(e)).toList();
  }

  Future<Note> createNote(Note input) async {
    final createdNoteEntity =
        await database.createNote(noteModelToEntity(input));
    return noteEntityToModel(createdNoteEntity);
  }

  Future<Note> updateNote(Note input) async {
    final updatedNoteEntity =
        await database.updateNote(noteModelToEntity(input));
    //TODO add check
    return input;
  }
}

Note noteEntityToModel(NoteEntity entity) {
  return Note(
    id: entity.id,
    noteName: entity.name,
    createdAt: DateTime.tryParse(entity.date),
    noteBody: entity.body,
    state: intToState(entity.state),
  );
}

NoteEntity noteModelToEntity(Note note) {
  return NoteEntity(
    id: note.id,
    name: note.noteName,
    body: note.noteBody,
    date: note.createdAt == null
        ? DateTime.now().toString()
        : note.createdAt.toString(),
    state: stateToInt(note.state),
  );
}

///Convert int state used in NoteEntity to NoteState
NoteState intToState(int noteEntityState) {
  switch (noteEntityState) {
    case 1:
      return NoteState.draft;
    case 2:
      return NoteState.live;
    case 3:
      return NoteState.archived;
  }
  throw Exception('Unsupported state');
}

///Convert int state used in NoteEntity to NoteState
int stateToInt(NoteState state) {
  switch (state) {
    case NoteState.draft:
      return 1;
    case NoteState.live:
      return 2;
    case NoteState.archived:
      return 3;
  }
}
