import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:note_app/features/manage_note/note_cubit/cubit.dart';
import 'package:note_app/models/note.dart';
import 'package:notes_database/models/note_entity.dart';
import 'package:notes_repository/notes_repository.dart';

import 'note_cubit_test.mocks.dart';

@GenerateMocks([NotesRepository])
void main() {
  group('Create new note strategy', () {
    group('iInitialise', () {
      blocTest<NoteCubit, NoteCubitState>(
        'Should initialise with empty note and state Loaded',
        build: () => NoteCubit(
          saveNoteStrategy: CreateNewNoteStrategy(MockNotesRepository()),
        ),
        act: (cubit) => cubit.iInitialise(),
        expect: () => <NoteCubitState>[
          NoteCubitState(status: NoteStatus.loaded, note: Note.empty()),
        ],
      );
    });

    group('iSaveTapped', () {
      late final MockNotesRepository notesRepositoryMock;
      final Note noteToSave = Note(
        noteName: 'Note name',
        noteBody: 'Note body',
        state: NoteState.draft,
      );
      blocTest<NoteCubit, NoteCubitState>(
        'Should save note',
        setUp: () {
          notesRepositoryMock = MockNotesRepository();
          when(notesRepositoryMock.createNote(any))
              .thenAnswer((_) async => NoteEntity(
                    id: 1,
                    state: 2,
                    name: noteToSave.noteName,
                    body: noteToSave.noteBody,
                    date: '2023-01-28',
                  ));
        },
        build: () => NoteCubit(
            saveNoteStrategy: CreateNewNoteStrategy(notesRepositoryMock),
            initialState:
                NoteCubitState(status: NoteStatus.loaded, note: noteToSave)),
        act: (bloc) {
          bloc.iSaveTapped(
            body: noteToSave.noteBody,
            title: noteToSave.noteName,
          );
        },
        expect: () => <NoteCubitState>[
          NoteCubitState(status: NoteStatus.loading, note: noteToSave),
          NoteCubitState(
            status: NoteStatus.saved,
            resultNote: noteToSave.copyWith(
              id: 1,
              createdAt: DateTime(2023, 01, 28),
              state: NoteState.live,
            ),
          ),
        ],
        verify: (_) {
          final verificationResults =
              verify(notesRepositoryMock.createNote(captureAny))..called(1);
          final input = verificationResults.captured.first as NoteEntity;
          expect(input.state, 2);
          expect(input.body, noteToSave.noteBody);
          expect(input.name, noteToSave.noteName);
          verifyNoMoreInteractions(notesRepositoryMock);
        },
      );
    });
  });
}
