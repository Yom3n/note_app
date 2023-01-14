library notes_repository;

import 'package:notes_database/notes_database.dart';

class NotesRepository {
  final NotesDatabase database;

  NotesRepository(this.database) {
    database.openDatabase();
  }
}
