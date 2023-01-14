import 'package:flutter/material.dart';

import '../../../models/note.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notes = [
      Note(
        id: 1,
        createdAt: DateTime.now(),
        noteName: 'Note 1',
        state: NoteState.live,
      ),
      Note(
        id: 2,
        createdAt: DateTime.now(),
        noteName: 'Note 2',
        state: NoteState.draft,
      ),
      Note(
        id: 2,
        createdAt: DateTime.now(),
        noteName: 'Note 3',
        state: NoteState.archived,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Your notes'),
      ),
      body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return NoteListItem(note: note);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          throw UnimplementedError();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class NoteListItem extends StatelessWidget {
  final Note note;

  const NoteListItem({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
