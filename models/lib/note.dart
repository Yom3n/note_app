import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum NoteState {
  //Note in the process of creation
  draft,

  // Approved note
  live,
  archived,
}

class Note {
  final int? id;
  final String noteName;
  final DateTime? createdAt;
  final String noteBody;
  final NoteState state;

  Note({
    this.id,
    this.createdAt,
    required this.noteName,
    required this.state,
    this.noteBody = '',
  });

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
}
