
import 'package:models/note.dart';

enum NotesStatus {
  loading,
  loaded,
  empty,
  createNewNote,
}

class NotesState {
  final NotesStatus status;
  final List<Note>? notes;

  NotesState({
    required this.status,
    this.notes = const [],
  });

  NotesState.loading({
    this.status = NotesStatus.loading,
    this.notes = const [],
  });

  NotesState.loaded({
    this.status = NotesStatus.loaded,
    required this.notes,
  });

  NotesState.empty({
    this.status = NotesStatus.empty,
    this.notes = const [],
  });

  NotesState.createNewNote({
    this.status = NotesStatus.createNewNote,
    this.notes = const [],
  });

  NotesState copyWith({NotesStatus? status, List<Note>? notes}) {
    return NotesState(
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }
}
