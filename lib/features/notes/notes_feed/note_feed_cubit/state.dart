import 'package:models/note.dart';

enum NotesFeedStatus {
  loading,
  loaded,
  empty,
  createNewNote,
  editNote,
}

class NotesFeedState {
  final NotesFeedStatus status;
  final List<Note>? notes;
  final int? noteToEditId;

  NotesFeedState({
    required this.status,
    this.notes = const [],
    this.noteToEditId,
  });

  NotesFeedState.loading({
    this.status = NotesFeedStatus.loading,
    this.notes = const [],
    this.noteToEditId,
  });

  NotesFeedState.loaded({
    this.status = NotesFeedStatus.loaded,
    required this.notes,
    this.noteToEditId,
  });

  NotesFeedState.empty({
    this.status = NotesFeedStatus.empty,
    this.notes = const [],
    this.noteToEditId,
  });

  NotesFeedState.createNewNote({
    this.status = NotesFeedStatus.createNewNote,
    this.notes = const [],
    this.noteToEditId,
  });

  NotesFeedState.editNote({
    this.status = NotesFeedStatus.editNote,
    required this.noteToEditId,
    this.notes = const [],
  });

  NotesFeedState copyWith({NotesFeedStatus? status, List<Note>? notes}) {
    return NotesFeedState(
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }
}
