import 'package:models/note.dart';

enum NotesFeedStatus {
  loading,
  loaded,
  empty,
  createNewNote,
}

class NotesFeedState {
  final NotesFeedStatus status;
  final List<Note>? notes;

  NotesFeedState({
    required this.status,
    this.notes = const [],
  });

  NotesFeedState.loading({
    this.status = NotesFeedStatus.loading,
    this.notes = const [],
  });

  NotesFeedState.loaded({
    this.status = NotesFeedStatus.loaded,
    required this.notes,
  });

  NotesFeedState.empty({
    this.status = NotesFeedStatus.empty,
    this.notes = const [],
  });

  NotesFeedState.createNewNote({
    this.status = NotesFeedStatus.createNewNote,
    this.notes = const [],
  });

  NotesFeedState copyWith({NotesFeedStatus? status, List<Note>? notes}) {
    return NotesFeedState(
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }
}
