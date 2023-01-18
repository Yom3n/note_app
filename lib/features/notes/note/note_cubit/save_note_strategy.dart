import 'package:models/note.dart';
import 'package:notes_repository/notes_repository.dart';

abstract class SaveNoteStrategyBase {
  Future<Note?> getInitialNote(int? noteId);

  Future<Note> saveNote(Note input);
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
  Future<Note> saveNote(Note input) async {
    return notesRepository.createNote(input);
  }
}

class UpdateNoteStrategy implements SaveNoteStrategyBase {
  final NotesRepository notesRepository;

  Note? initialNote;

  UpdateNoteStrategy(this.notesRepository);

  @override
  Future<Note?> getInitialNote(int? noteId) async {
    assert(noteId != null);
    initialNote = await notesRepository.getNoteById(noteId!);
    return initialNote;
  }

  @override
  Future<Note> saveNote(Note input) async {
    assert(initialNote != null);
    return notesRepository.updateNote(initialNote!.copyWith(
      noteName: input.noteName,
      noteBody: input.noteBody,
    ));
  }
}
