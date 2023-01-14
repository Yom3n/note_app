import 'package:bloc/bloc.dart';
import 'package:notes_repository/notes_repository.dart';

import 'state.dart';

class NotesBlocCubit extends Cubit<NotesState> {
  final NotesRepository repository;

  NotesBlocCubit(this.repository) : super(NotesState.loading());

  Future<void> iInitialise() {
    repository.
  }
}
