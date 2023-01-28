import 'package:equatable/equatable.dart';

import '../../../../models/note.dart';


enum NoteStatus {
  loading,
  loaded,
  saved,
  error,
}

class NoteCubitState extends Equatable {
  //Output of note page. Null, created or updated note
  final Note? resultNote;

  final NoteStatus status;
  final Note? note;

  const NoteCubitState({
    required this.status,
    this.resultNote,
    this.note,
  });

  NoteCubitState copyWith({
    NoteStatus? status,
    Note? note,
  }) {
    return NoteCubitState(
      status: status ?? this.status,
      note: note ?? this.note,
      resultNote: resultNote,
    );
  }

  @override
  List<Object?> get props => [
        status,
        resultNote,
        note,
      ];
}
