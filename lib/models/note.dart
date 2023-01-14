enum NoteState {
  //Notein  the process of creation
  draft,

  // Approved note
  live,
  archived,
}

class Note {
  final int id;
  final String noteName;
  final DateTime createdAt;
  final String noteBody;
  final NoteState state;

  Note({
    required this.id,
    required this.noteName,
    required this.createdAt,
    required this.state,
    this.noteBody = '',
  });
}
