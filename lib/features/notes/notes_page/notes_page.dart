import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/note.dart';
import 'package:note_app/features/notes/notes_page/bloc/notes_cubit/state.dart';

import '../../../dsm/loading_indicator.dart';
import 'bloc/notes_cubit/cubit.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your notes'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            switch (state.status) {
              case NotesStatus.loading:
                return NaLoadingIndicator();
              case NotesStatus.loaded:
                return NotesFeed(state.notes);
              case NotesStatus.empty:
                return NotesFeedEmptyBody();
              case NotesStatus.createNewNote:
                return NotesFeed(state.notes);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<NotesCubit>().iAddNoteTapped();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class NotesFeedEmptyBody extends StatelessWidget {
  const NotesFeedEmptyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Nothing to show.\nCreate new note'),
    );
  }
}

class NotesFeed extends StatelessWidget {
  final List<Note>? notes;

  const NotesFeed(this.notes, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(notes != null);
    return ListView.builder(
        itemCount: notes!.length,
        itemBuilder: (context, index) {
          final note = notes![index];
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: NoteListItem(
                key: Key('Note-item-${note.id}'),
                note: note,
                onNoteDeleteTapped: () => throw UnimplementedError(),
                onNoteOpenedTapped: () => throw UnimplementedError(),
              ));
        });
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
