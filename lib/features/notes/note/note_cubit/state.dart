import 'package:models/note.dart';

enum NoteStatus {
  loading,
  loaded,
  saved,
}

class NoteCubitState {
  final Note? createdNote;

  final NoteStatus status;
  final Note? initialNote;

  NoteCubitState({
    required this.status,
    this.createdNote,
    this.initialNote,
  });

  NoteCubitState copyWith({NoteStatus? status}) {
    return NoteCubitState(status: status ?? this.status);
  }
}
