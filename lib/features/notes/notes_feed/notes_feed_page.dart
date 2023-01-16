import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/note.dart';

import '../../../dsm/na_loading_indicator.dart';
import '../../../dsm/na_page.dart';
import '../../../routes.dart';
import 'note_feed_cubit/cubit.dart';

class NotesFeedPage extends StatelessWidget {
  const NotesFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NaPage(
      title: 'Your notes',
      body: BlocConsumer<NotesFeedCubit, NotesFeedState>(
        listener: (context, state) {
          if (state.status == NotesFeedStatus.createNewNote) {
            Future.delayed(Duration.zero, () async {
              final createdNote =
                  await Navigator.push(context, createNoteRoute());
              context.read<NotesFeedCubit>().iNoteCreated(createdNote);
            });
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case NotesFeedStatus.loading:
              return NaLoadingIndicator();
            case NotesFeedStatus.loaded:
              return NotesFeed(state.notes);
            case NotesFeedStatus.empty:
              return NotesFeedEmptyBody();
            case NotesFeedStatus.createNewNote:
              return NotesFeed(state.notes);
          }
        },
      ),
      fab: FloatingActionButton(
        onPressed: () {
          context.read<NotesFeedCubit>().iAddNoteTapped();
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
        decoration: BoxDecoration(
          borderRadius: _getBorderRadius(),
          color: note.getStateColor().withAlpha(128),
        ),
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    note.noteName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  if (note.noteBody.isNotEmpty)
                    IntrinsicWidth(
                      child: Text(
                        note.noteBody,
                        maxLines: 2,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  Text(note.getFormattedCreationDate()),
                ],
              ),
            ),
            SizedBox(width: 10),
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
