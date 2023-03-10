import 'package:bloc/bloc.dart';
import 'package:note_app/features/manage_note/note_cubit/save_note_strategy.dart';

import '../../../../models/note.dart';
import 'state.dart';

export 'save_note_strategy.dart';
export 'state.dart';

class NoteCubit extends Cubit<NoteCubitState> {
  final SaveNoteStrategyBase saveNoteStrategy;

  NoteCubit({
    required this.saveNoteStrategy,
  }) : super(NoteCubitState(status: NoteStatus.loading));

  Future<void> iInitialise({int? noteId}) async {
    try {
      final _initialNote = await saveNoteStrategy.getInitialNote(noteId);
      emit(
        NoteCubitState(
          status: NoteStatus.loaded,
          initialNote: _initialNote,
        ),
      );
    } catch (e) {
      print(e.toString());
      emit(NoteCubitState(status: NoteStatus.error));
    }
  }

  Future<void> iSaveTapped({
    required String title,
    required String body,
  }) async {
    emit(state.copyWith(status: NoteStatus.loading));
    final input = Note(noteName: title, noteBody: body, state: NoteState.live);
    try {
      final output = await saveNoteStrategy.saveNote(input, state.initialNote);
      emit(NoteCubitState(status: NoteStatus.saved, resultNote: output));
    } catch (e) {
      print(e.toString());
      emit(NoteCubitState(status: NoteStatus.error));
    }
  }
}
