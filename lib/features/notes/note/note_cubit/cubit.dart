import 'package:bloc/bloc.dart';
import 'package:models/note.dart';
import 'package:notes_repository/notes_repository.dart';

import 'state.dart';
export 'state.dart';

class NoteCubit extends Cubit<NoteCubitState> {
  final NotesRepository notesRepository;

  NoteCubit(this.notesRepository)
      : super(NoteCubitState(status: NoteStatus.loading));

  Future<void> iInitialise() async {
    emit(NoteCubitState(status: NoteStatus.loaded));
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
