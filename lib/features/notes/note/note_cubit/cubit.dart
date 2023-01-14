import 'package:bloc/bloc.dart';
import 'package:models/note.dart';
import 'package:notes_repository/notes_repository.dart';

import 'state.dart';

class NoteCubit extends Cubit<NoteCubitState> {
  final NotesRepository notesRepository;

  NoteCubit(this.notesRepository) : super(NoteCubitState().init());

  Future<void> iInitialise() async {}

  Future<void> iCreateNote(Note note) async {
    assert(note.id == null, 'Dont setup ID when creating new note!');
    assert(note.noteName.isNotEmpty);
    final createdNote = await notesRepository.createNote(note);
  }
}
