import 'package:notes_repository/notes_repository.dart';

import '../../../../models/note.dart';

abstract class SaveNoteStrategyBase {
  Future<Note?> getInitialNote(int? noteId);

  Future<Note?> saveNote(Note? input, Note? initialNote);
}

class CreateNewNoteStrategy implements SaveNoteStrategyBase {
  final NotesRepository notesRepository;

  CreateNewNoteStrategy(this.notesRepository);

  @override
  Future<Note?> getInitialNote(int? noteId) async {
    return Note(
      noteName: '',
      state: NoteState.draft,
    );
  }

  @override
  Future<Note?> saveNote(Note? input, Note? initialNote) async {
    assert(input != null);
    final createdEntity =
        await notesRepository.createNote(input!.toNoteEntity());
    if (createdEntity != null) {
      return Note.fromNoteEntity(createdEntity);
    } else {
      throw Exception('An error occurred while saving note');
    }
  }
}

class UpdateNoteStrategy implements SaveNoteStrategyBase {
  final NotesRepository notesRepository;

  Note? initialNote;

  UpdateNoteStrategy(this.notesRepository);

  @override
  Future<Note?> getInitialNote(int? noteId) async {
    assert(noteId != null);
    final initialNoteEntity = await notesRepository.getNoteById(noteId!);
    if (initialNoteEntity != null) {
      return initialNote = Note.fromNoteEntity(initialNoteEntity);
    }
    throw Exception('An error occurred while fetching note');
  }

  @override
  Future<Note?> saveNote(Note? input, Note? initialNote) async {
    assert(input != null);
    assert(initialNote != null);
    final noteToUpdate = initialNote!.copyWith(
      noteName: input!.noteName,
      noteBody: input.noteBody,
    );
    final updatedNoteEntity =
        await notesRepository.updateNote(noteToUpdate.toNoteEntity());
    if (updatedNoteEntity != null) {
      return Note.fromNoteEntity(updatedNoteEntity);
    }
    return Note.empty(); //TODO Throw exception;
  }
}
