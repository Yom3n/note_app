import 'package:bloc/bloc.dart';
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
}
