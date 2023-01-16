import 'package:bloc/bloc.dart';
import 'package:models/note.dart';
import 'package:notes_repository/notes_repository.dart';

import 'state.dart';
export 'state.dart';

class BaseNoteCubit extends Cubit<NoteCubitState> {
  final NotesRepository notesRepository;

  BaseNoteCubit(this.notesRepository)
      : super(NoteCubitState(status: NoteStatus.loading));
}

class CreateNoteCubit extends BaseNoteCubit {
  CreateNoteCubit(NotesRepository notesRepository) : super(notesRepository);

  Future<void> iInitialise() async {
    emit(
      NoteCubitState(
        status: NoteStatus.loaded,
        initialNote: Note(
          noteName: '',
          state: NoteState.draft,
        ),
      ),
    );
  }

  Future<void> iCreateNote({
    required String title,
    required String body,
  }) async {
    emit(NoteCubitState(status: NoteStatus.loading));
    final note = Note(noteName: title, noteBody: body, state: NoteState.live);
    final createdNote = await notesRepository.createNote(note);
    emit(NoteCubitState(status: NoteStatus.saved, createdNote: createdNote));
  }
}

class EditNoteCubit extends BaseNoteCubit {
  EditNoteCubit(NotesRepository notesRepository) : super(notesRepository);

  Future<void> iInitialise(int noteId) async {
    emit(NoteCubitState(status: NoteStatus.loading));
    final note = await notesRepository.getNoteById(noteId);
    emit(NoteCubitState(status: NoteStatus.loaded, initialNote: note));
  }

  Future<void> iUpdateNote({
    required String title,
    required String body,
  }) async {
    emit(NoteCubitState(status: NoteStatus.loading));
    final note = state.initialNote!.copyWith(
      noteBody: body,
      noteName: title,
    );
    final updatedNote = await notesRepository.createNote(note);
    emit(NoteCubitState(status: NoteStatus.saved, createdNote: updatedNote));
  }
}
