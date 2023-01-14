import 'package:bloc/bloc.dart';
import 'package:models/note.dart';
import 'package:notes_repository/notes_repository.dart';

import 'state.dart';

class NotesCubit extends Cubit<NotesState> {
  final NotesRepository repository;

  NotesCubit(this.repository) : super(NotesState.loading());

  Future<void> iInitialise() async {
    final notes = await repository.getNotes();
    if (notes.isEmpty) {
      emit(NotesState.empty());
    } else {
      emit(NotesState.loaded(notes: notes));
    }
  }

  Future<void> iAddNoteTapped() async {
    final createdNote = await repository.createNote(Note(
      state: NoteState.live,
      noteName: 'Note name',
      noteBody: 'Some body',
    ));
    final updatedNotes = List<Note>.from(state.notes ?? [])..add(createdNote);
    final updatedState =
        state.copyWith(notes: updatedNotes, status: NotesStatus.loaded);
    emit(updatedState);
  }
}
