import 'package:bloc/bloc.dart';
import 'package:note_app/features/notes/note/note_cubit/save_note_strategy.dart';
import 'package:notes_repository/notes_repository.dart';

import '../../models/note.dart';
import 'state.dart';

export 'save_note_strategy.dart';
export 'state.dart';

class NoteCubit extends Cubit<NoteCubitState> {
  final NotesRepository notesRepository;

  final SaveNoteStrategyBase saveNoteStrategy;

  NoteCubit({
    required this.notesRepository,
    required this.saveNoteStrategy,
  }) : super(NoteCubitState(status: NoteStatus.loading));

  Future<void> iInitialise({int? noteId}) async {
    final initialNote = await saveNoteStrategy.getInitialNote(noteId);
    emit(
      NoteCubitState(
        status: NoteStatus.loaded,
        note: initialNote,
      ),
    );
  }

  Future<void> iSaveTapped({
    required String title,
    required String body,
  }) async {
    emit(state.copyWith(status: NoteStatus.loading));
    final note = Note(noteName: title, noteBody: body, state: NoteState.live);
    final output = await saveNoteStrategy.saveNote(note);
    emit(NoteCubitState(status: NoteStatus.saved, resultNote: output));
  }
}
