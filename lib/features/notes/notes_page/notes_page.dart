import 'package:flutter/material.dart';
import 'package:models/note.dart';


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
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: NoteListItem(
                    note: note,
                    onNoteDeleteTapped: () => throw UnimplementedError(),
                    onNoteOpenedTapped: () => throw UnimplementedError(),
                  ));
            }),
      ),
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
  final VoidCallback onNoteOpenedTapped;
  final VoidCallback onNoteDeleteTapped;

  const NoteListItem({
    Key? key,
    required this.note,
    required this.onNoteOpenedTapped,
    required this.onNoteDeleteTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: onNoteOpenedTapped,
      borderRadius: _getBorderRadius(),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: _getBorderRadius(),
          color: note.getStateColor().withAlpha(128),
        ),
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(note.noteName,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(note.getFormattedCreationDate()),
              ],
            ),
            GestureDetector(
              onTap: onNoteDeleteTapped,
              child: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius() {
    return BorderRadius.circular(12);
  }
}
