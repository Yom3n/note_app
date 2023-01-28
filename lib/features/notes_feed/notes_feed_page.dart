import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dsm/na_loading_indicator.dart';
import '../../../dsm/na_page.dart';
import '../../../models/note.dart';
import '../../../routes.dart';
import 'note_feed_cubit/cubit.dart';

class NotesFeedPage extends StatelessWidget {
  const NotesFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NaPage(
      title: 'Your notes',
      body: BlocConsumer<NotesFeedCubit, NotesFeedState>(
        listener: (context, state) => _handleNavigation(state, context),
        builder: (context, state) {
          switch (state.status) {
            case NotesFeedStatus.loading:
              return NaLoadingIndicator();
            case NotesFeedStatus.empty:
              return NotesFeedEmptyBody();
            case NotesFeedStatus.loaded:
            case NotesFeedStatus.createNewNote:
            case NotesFeedStatus.editNote:
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

  Future<void> _handleNavigation(
      NotesFeedState state, BuildContext context) async {
    if (state.status == NotesFeedStatus.createNewNote) {
      Future.delayed(Duration.zero, () async {
        final createdNote = await Navigator.push(context, createNoteRoute());
        context.read<NotesFeedCubit>().iNoteCreated(createdNote);
      });
    }
    if (state.status == NotesFeedStatus.editNote) {
      Future.delayed(Duration.zero, () async {
        assert(state.noteToEditId != null);
        final updatedNote =
            await Navigator.push(context, editNoteRoute(state.noteToEditId!));
        context.read<NotesFeedCubit>().iNoteUpdated(updatedNote);
      });
    }
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
                key: Key('Note-item-${note.toString()}'),
                note: note,
                onNoteDeleteTapped: () =>
                    context.read<NotesFeedCubit>().iArchiveNote(note.id!),
                onNoteOpenedTapped: () {
                  context.read<NotesFeedCubit>().iUpdateNoteTapped(note.id!);
                },
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
                        style: TextStyle(
                            fontSize: 12, fontStyle: FontStyle.italic),
                      ),
                    ),
                  Text(note.getFormattedCreationDate()),
                ],
              ),
            ),
            SizedBox(width: 10),
            if (note.state != NoteState.archived)
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
