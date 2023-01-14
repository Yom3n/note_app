import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/models/note.dart';

void main() {
  test('Test formatted date getter', () {
    //Arrange
    final Note note = Note(
      id: 1,
      createdAt: DateTime(2022, 8, 18, 15, 4),
      noteName: 'Note 1',
      state: NoteState.live,
    );
    //Act
    final result = note.getFormattedCreationDate();
    //Assert
    expect(result, '2022-08-18 15:04');
  });
}
