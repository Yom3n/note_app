import 'package:bloc/bloc.dart';
import 'package:models/note.dart';
import 'package:notes_repository/notes_repository.dart';

import 'state.dart';

export 'state.dart';

class NotesFeedCubit extends Cubit<NotesFeedState> {
  final NotesRepository repository;

  NotesFeedCubit(this.repository) : super(NotesFeedState.loading());

  Future<void> iInitialise() async {
    final notes = await repository.getNotes();
    if (notes.isEmpty) {
      emit(NotesFeedState.empty());
    } else {
      emit(NotesFeedState.loaded(notes: notes));
    }
  }

  Future<void> iAddNoteTapped() async {
    emit(state.copyWith(status: NotesFeedStatus.createNewNote));
  }

  void iNoteCreated(Note? newNote) {
    if (newNote == null) {
      emit(state.copyWith(status: NotesFeedStatus.loaded));
    } else {
      final updatedNotes = List<Note>.from(state.notes ?? [])..add(newNote);
      final updatedState =
          state.copyWith(notes: updatedNotes, status: NotesFeedStatus.loaded);
      emit(updatedState);
    }
  }
}
