library notes_repository;

import 'package:notes_database/notes_database.dart';
import 'package:models/note.dart';
import 'package:notes_database/models/note_entity.dart';

class NotesRepository {
  final NotesDatabase database;

  NotesRepository(this.database) {
    database.openDatabase();
  }

  Future<List<Note>> getNotes() async {
    final notesEntities = await database.getNotes();
    return notesEntities.map((e) => noteEntityToModel(e)).toList();
  }
}

Note noteEntityToModel(NoteEntity entity) {
  return Note(
    id: entity.id,
    noteName: entity.name,
    createdAt: DateTime.parse(entity.date),
    noteBody: entity.body,
    state: intToState(entity.state),
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
