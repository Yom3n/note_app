import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_database/models/note_entity.dart';
import 'package:notes_database/notes_database.dart';
import 'package:notes_repository/notes_repository.dart';

import 'notes_repository_test.mocks.dart';

@GenerateMocks([NotesDatabase])
void main() {
  NotesRepository? sut;
  MockNotesDatabase? mockNotesDatabase;

  setUp(() {
    mockNotesDatabase = MockNotesDatabase();
    return sut = NotesRepository(mockNotesDatabase!);
  });

  group('GetNoteById', () {
    test('Should get note by id', () async {
      // Arrange
      const tNoteId = 123;
      final tNoteEntity = NoteEntity(id: tNoteId, name: 'tName', state: 1);
      when(mockNotesDatabase!.getNote(any))
          .thenAnswer((_) async => tNoteEntity);
      // Act
      final result = await sut!.getNoteById(tNoteId);
      // Asser
      expect(result, tNoteEntity);
      verify(mockNotesDatabase!.getNote(tNoteId)).called(1);
      verifyNoMoreInteractions(mockNotesDatabase);
    });

    test('When note does not exist should return null', () async {
      // Arrange
      when(mockNotesDatabase!.getNote(any)).thenAnswer((_) async => null);
      // Act
      final result = await sut!.getNoteById(123);
      // Asser
      expect(result, null);
    });
  });

  group('GetNotes', () {
    test(
        'Should return all notes in database',
        () => () async {
              //Arrange
              final tNotes = List.generate(
                3,
                (index) => NoteEntity(
                  name: index.toString(),
                  state: 1,
                ),
              );
              when(mockNotesDatabase!.getNotes())
                  .thenAnswer((realInvocation) async => tNotes);
              //Act
              final result = await sut!.getNotes();
              //Assert
              expect(result, tNotes);
              verify(mockNotesDatabase!.getNotes()).called(1);
              verifyNoMoreInteractions(mockNotesDatabase);
            });
  });
}
