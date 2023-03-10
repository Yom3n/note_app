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
  MockNotesRepository notesRepositoryMock = MockNotesRepository();

  setUp(() {
    notesRepositoryMock = MockNotesRepository();
  });

  group('Create new note strategy', () {
    group('iInitialise', () {
      blocTest<NoteCubit, NoteCubitState>(
        'Should initialise with empty note and state Loaded',
        build: () => NoteCubit(
          saveNoteStrategy: CreateNewNoteStrategy(notesRepositoryMock),
        ),
        act: (cubit) => cubit.iInitialise(),
        expect: () => <NoteCubitState>[
          NoteCubitState(status: NoteStatus.loaded, initialNote: Note.empty()),
        ],
      );
    });

    group('iSaveTapped', () {
      final Note noteToSave = Note(
        noteName: 'Note name',
        noteBody: 'Note body',
        state: NoteState.draft,
      );

      blocTest<NoteCubit, NoteCubitState>(
        'Test saving note successfull path',
        setUp: () {
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
        ),
        seed: () => NoteCubitState(
            status: NoteStatus.loaded, initialNote: Note.empty()),
        act: (bloc) {
          bloc.iSaveTapped(
            body: noteToSave.noteBody,
            title: noteToSave.noteName,
          );
        },
        expect: () => <NoteCubitState>[
          NoteCubitState(status: NoteStatus.loading, initialNote: Note.empty()),
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

      blocTest<NoteCubit, NoteCubitState>(
        'Test saving note error',
        setUp: () {
          when(notesRepositoryMock.createNote(any)).thenThrow(Exception());
        },
        build: () => NoteCubit(
          saveNoteStrategy: CreateNewNoteStrategy(notesRepositoryMock),
        ),
        seed: () => NoteCubitState(
            status: NoteStatus.loaded, initialNote: Note.empty()),
        act: (bloc) {
          bloc.iSaveTapped(
            body: noteToSave.noteBody,
            title: noteToSave.noteName,
          );
        },
        // Skips loading state
        skip: 1,
        expect: () => <NoteCubitState>[
          NoteCubitState(status: NoteStatus.error),
        ],
      );
    });
  });

  group('Update existing note strategy', () {
    final tInitialNote = Note(
      id: 123,
      state: NoteState.live,
      noteName: 'note name',
      noteBody: 'note body',
      createdAt: DateTime(2023, 01, 01),
    );

    group('iInitialise', () {
      blocTest<NoteCubit, NoteCubitState>(
          'Test cubit is initialized with note fetched from repository',
          setUp: () {
            when(notesRepositoryMock.getNoteById(any))
                .thenAnswer((_) async => NoteEntity(
                      name: tInitialNote.noteName,
                      state: 2,
                      id: tInitialNote.id,
                      body: tInitialNote.noteBody,
                      date: '2023-01-01',
                    ));
          },
          build: () => NoteCubit(
              saveNoteStrategy: UpdateNoteStrategy(notesRepositoryMock)),
          act: (bloc) {
            bloc.iInitialise(noteId: tInitialNote.id);
          },
          expect: () => <NoteCubitState>[
                NoteCubitState(
                    status: NoteStatus.loaded, initialNote: tInitialNote),
              ],
          verify: (_) {
            verify(notesRepositoryMock.getNoteById(tInitialNote.id));
            verifyNoMoreInteractions(notesRepositoryMock);
          });

      blocTest<NoteCubit, NoteCubitState>(
        'Test streams Error when initialisation go wrong',
        setUp: () {
          when(notesRepositoryMock.getNoteById(any)).thenThrow(Exception());
        },
        build: () => NoteCubit(
            saveNoteStrategy: UpdateNoteStrategy(notesRepositoryMock)),
        act: (bloc) {
          bloc.iInitialise(noteId: tInitialNote.id);
        },
        expect: () => <NoteCubitState>[
          NoteCubitState(status: NoteStatus.error),
        ],
      );
    });

    group('iSave', () {
      const String updatedNoteName = 'Updated note name';
      const String updatedNoteBody = 'Updated note body';

      blocTest<NoteCubit, NoteCubitState>(
        'Test updating note',
        setUp: () {
          when(notesRepositoryMock.updateNote(any))
              .thenAnswer((_) async => NoteEntity(
                    id: tInitialNote.id,
                    name: updatedNoteName,
                    body: updatedNoteBody,
                    date: '2023-01-01',
                    state: 2,
                  ));
        },
        build: () => NoteCubit(
          saveNoteStrategy: UpdateNoteStrategy(notesRepositoryMock),
        ),
        seed: () => NoteCubitState(
            status: NoteStatus.loaded, initialNote: tInitialNote),
        act: (bloc) {
          bloc.iSaveTapped(title: updatedNoteName, body: updatedNoteBody);
        },
        skip: 1,
        expect: () => <NoteCubitState>[
          NoteCubitState(
              status: NoteStatus.saved,
              resultNote: tInitialNote.copyWith(
                  noteName: updatedNoteName, noteBody: updatedNoteBody))
        ],
      );

      blocTest<NoteCubit, NoteCubitState>(
        'Test error when updating note',
        setUp: () {
          when(notesRepositoryMock.updateNote(any)).thenThrow(Exception());
        },
        seed: () => NoteCubitState(
          status: NoteStatus.loaded,
          initialNote: tInitialNote,
        ),
        build: () => NoteCubit(
          saveNoteStrategy: UpdateNoteStrategy(notesRepositoryMock),
        ),
        act: (bloc) {
          bloc.iSaveTapped(title: 'Title', body: 'Body');
        },
        skip: 1,
        expect: () => <NoteCubitState>[
          NoteCubitState(status: NoteStatus.error),
        ],
      );
    });
  });
}
