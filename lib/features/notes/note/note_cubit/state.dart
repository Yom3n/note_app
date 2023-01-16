import 'package:models/note.dart';

enum NoteStatus {
  loading,
  loaded,
  saved,
}

class NoteCubitState {
  //Output of note page. Null, created or updated note
  final Note? resultNote;

  final NoteStatus status;
  final Note? initialNote;

  NoteCubitState({
    required this.status,
    this.resultNote,
    this.initialNote,
  });

  NoteCubitState copyWith({NoteStatus? status}) {
    return NoteCubitState(
      status: status ?? this.status,
      initialNote: initialNote,
      resultNote: resultNote,
    );
  }
}
