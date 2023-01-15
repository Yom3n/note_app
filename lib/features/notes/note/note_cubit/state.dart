import 'package:models/note.dart';

enum NoteStatus {
  loading,
  loaded,
  saved,
}

class NoteCubitState {
  final Note? createdNote;

  final NoteStatus status;

  NoteCubitState({required this.status, this.createdNote});

  NoteCubitState copyWith({NoteStatus? status}) {
    return NoteCubitState(status: status ?? this.status);
  }
}
