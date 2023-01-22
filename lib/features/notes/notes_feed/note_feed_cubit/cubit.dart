import 'package:bloc/bloc.dart';
import 'package:notes_repository/notes_repository.dart';

import '../../models/note.dart';
import 'state.dart';

export 'state.dart';

class NotesFeedCubit extends Cubit<NotesFeedState> {
  final NotesRepository repository;

  NotesFeedCubit(this.repository) : super(NotesFeedState.loading());

  Future<void> iInitialise() async {
    final notesEntities = await repository.getNotes();
    if (notesEntities.isEmpty) {
      emit(NotesFeedState.empty());
    } else {
      final notes = notesEntities.map((e) => Note.fromNoteEntity(e)).toList();
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

  void iUpdateNoteTapped(int id) {
    emit(NotesFeedState.editNote(notes: state.notes, noteToEditId: id));
  }

  void iNoteUpdated(Note? updatedNote) {
    if (updatedNote == null) {
      emit(state.copyWith(status: NotesFeedStatus.loaded));
    } else {
      assert(updatedNote.id != null);
      final notes = List<Note>.from(state.notes ?? []);
      final indexToUpdate =
          notes.indexWhere((element) => element.id == updatedNote.id);
      if (indexToUpdate == -1) {
        throw RangeError('Note does not exist');
      }
      notes[indexToUpdate] = updatedNote;
      final updatedState = state.copyWith(
        notes: notes,
        status: NotesFeedStatus.loaded,
      );
      emit(updatedState);
    }
  }

  Future<void> iArchiveNote(int noteId) async {
    final archivedNoteEntity = await repository.archiveNote(noteId);
    if (archivedNoteEntity != null) {
      iNoteUpdated(Note.fromNoteEntity(archivedNoteEntity));
    }
  }
}
