import 'package:bloc/bloc.dart';
import 'package:models/note.dart';
import 'package:notes_repository/notes_repository.dart';

import 'state.dart';
export 'state.dart';

abstract class BaseNoteCubit extends Cubit<NoteCubitState> {
  final NotesRepository notesRepository;

  BaseNoteCubit(this.notesRepository)
      : super(NoteCubitState(status: NoteStatus.loading));

  Future<void> iSaveTapped({
    required String title,
    required String body,
  });
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

  @override
  Future<void> iSaveTapped({
    required String title,
    required String body,
  }) async {
    emit(state.copyWith(status: NoteStatus.loading));
    final note = Note(noteName: title, noteBody: body, state: NoteState.live);
    final createdNote = await notesRepository.createNote(note);
    emit(NoteCubitState(status: NoteStatus.saved, resultNote: createdNote));
  }
}

class EditNoteCubit extends BaseNoteCubit {
  EditNoteCubit(NotesRepository notesRepository) : super(notesRepository);

  Future<void> iInitialise(int noteId) async {
    emit(NoteCubitState(status: NoteStatus.loading));
    final note = await notesRepository.getNoteById(noteId);
    emit(NoteCubitState(status: NoteStatus.loaded, initialNote: note));
  }

  @override
  Future<void> iSaveTapped({
    required String title,
    required String body,
  }) async {
    emit(state.copyWith(status: NoteStatus.loading));
    final note = state.initialNote!.copyWith(
      noteBody: body,
      noteName: title,
    );
    final updatedNote = await notesRepository.updateNote(note);
    emit(NoteCubitState(
      status: NoteStatus.saved,
      resultNote: updatedNote,
    ));
  }
}
