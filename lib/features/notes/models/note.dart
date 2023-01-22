import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_database/models/note_entity.dart';

enum NoteState {
  //Note in the process of creation
  draft,

  // Approved note
  live,
  archived,
}

class Note extends Equatable {
  final int? id;
  final String noteName;
  final DateTime? createdAt;
  final String noteBody;
  final NoteState state;

  const Note({
    this.id,
    this.createdAt,
    required this.noteName,
    required this.state,
    this.noteBody = '',
  });

  const Note.empty({
    this.id,
    this.createdAt,
    this.noteName = '',
    this.state = NoteState.draft,
    this.noteBody = '',
  });

  Note.fromNoteEntity(NoteEntity entity)
      : id = entity.id,
        createdAt = DateTime.tryParse(entity.date),
        noteName = entity.name,
        noteBody = entity.body,
        state = intToState(entity.state);

  ///Returns date formatted to  2022-08-18 15:04
  String getFormattedCreationDate() {
    if (createdAt == null) {
      return '';
    }
    try {
      return DateFormat('yyyy-MM-dd HH:mm').format(createdAt!);
    } on FormatException {
      return '';
    }
  }

  Color getStateColor() {
    switch (state) {
      case NoteState.draft:
        return Colors.lightBlueAccent;
      case NoteState.live:
        return Colors.greenAccent;
      case NoteState.archived:
        return Colors.redAccent;
    }
  }

  Note copyWith({
    int? id,
    String? noteName,
    String? noteBody,
    NoteState? state,
  }) {
    return Note(
      id: id ?? this.id,
      state: state ?? this.state,
      noteName: noteName ?? this.noteName,
      noteBody: noteBody ?? this.noteBody,
      createdAt: createdAt,
    );
  }

  NoteEntity toNoteEntity() {
    return NoteEntity(
      id: id,
      name: noteName,
      body: noteBody,
      date:
          createdAt == null ? DateTime.now().toString() : createdAt.toString(),
      state: stateToInt(state),
    );
  }

  ///Convert int state used in NoteEntity to NoteState
  static NoteState intToState(int noteEntityState) {
    switch (noteEntityState) {
      case 1:
        return NoteState.draft;
      case 2:
        return NoteState.live;
      case 3:
        return NoteState.archived;
    }
    throw Exception('Unsupported state');
  }

  ///Convert int state used in NoteEntity to NoteState
  static int stateToInt(NoteState state) {
    switch (state) {
      case NoteState.draft:
        return 1;
      case NoteState.live:
        return 2;
      case NoteState.archived:
        return 3;
    }
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        noteName,
        state,
        noteBody,
      ];
}
