import 'package:equatable/equatable.dart';

import '../../models/note.dart';

enum NotesFeedStatus {
  loading,
  loaded,
  empty,
  createNewNote,
  editNote,
}

class NotesFeedState extends Equatable {
  final NotesFeedStatus status;
  final List<Note>? notes;
  final int? noteToEditId;

  const NotesFeedState({
    required this.status,
    this.notes = const [],
    this.noteToEditId,
  });

  const NotesFeedState.loading({
    this.status = NotesFeedStatus.loading,
    this.notes = const [],
    this.noteToEditId,
  });

  const NotesFeedState.loaded({
    this.status = NotesFeedStatus.loaded,
    required this.notes,
    this.noteToEditId,
  });

  const NotesFeedState.empty({
    this.status = NotesFeedStatus.empty,
    this.notes = const [],
    this.noteToEditId,
  });

  const NotesFeedState.createNewNote({
    this.status = NotesFeedStatus.createNewNote,
    this.notes = const [],
    this.noteToEditId,
  });

  const NotesFeedState.editNote({
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

  @override
  List<Object?> get props => [
        status,
        notes,
        noteToEditId,
      ];
}
