import 'package:get_it/get_it.dart';
import 'package:notes_database/notes_database.dart';
import 'package:notes_repository/notes_repository.dart';

final sl = GetIt.instance;

void initializeServiceLocator() {
  sl
    ..registerSingleton(NotesDatabase())
    ..registerSingleton(NotesRepository(sl()));
}
