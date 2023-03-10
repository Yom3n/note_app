// Mocks generated by Mockito 5.3.2 from annotations
// in notes_repository/test/notes_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:notes_database/models/note_entity.dart' as _i2;
import 'package:notes_database/notes_database.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeNoteEntity_0 extends _i1.SmartFake implements _i2.NoteEntity {
  _FakeNoteEntity_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NotesDatabase].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotesDatabase extends _i1.Mock implements _i3.NotesDatabase {
  MockNotesDatabase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> openDatabase() => (super.noSuchMethod(
        Invocation.method(
          #openDatabase,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<_i2.NoteEntity> createNote(_i2.NoteEntity? noteEntity) =>
      (super.noSuchMethod(
        Invocation.method(
          #createNote,
          [noteEntity],
        ),
        returnValue: _i4.Future<_i2.NoteEntity>.value(_FakeNoteEntity_0(
          this,
          Invocation.method(
            #createNote,
            [noteEntity],
          ),
        )),
      ) as _i4.Future<_i2.NoteEntity>);
  @override
  _i4.Future<List<_i2.NoteEntity>> getNotes() => (super.noSuchMethod(
        Invocation.method(
          #getNotes,
          [],
        ),
        returnValue: _i4.Future<List<_i2.NoteEntity>>.value(<_i2.NoteEntity>[]),
      ) as _i4.Future<List<_i2.NoteEntity>>);
  @override
  _i4.Future<_i2.NoteEntity?> getNote(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getNote,
          [id],
        ),
        returnValue: _i4.Future<_i2.NoteEntity?>.value(),
      ) as _i4.Future<_i2.NoteEntity?>);
  @override
  _i4.Future<bool> updateNote(_i2.NoteEntity? note) => (super.noSuchMethod(
        Invocation.method(
          #updateNote,
          [note],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
