import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/notes/note/note_cubit/cubit.dart';
import 'package:note_app/service_locator.dart';

import 'features/notes/models/note.dart';
import 'features/notes/note/note_page.dart';

MaterialPageRoute<Note> createNoteRoute() {
  return MaterialPageRoute(
      builder: (context) => BlocProvider<NoteCubit>(
            create: (context) => NoteCubit(
                notesRepository: sl(),
                saveNoteStrategy: CreateNewNoteStrategy(
                  sl(),
                ))
              ..iInitialise(),
            child: NotePage(),
          ));
}

MaterialPageRoute<Note> editNoteRoute(int noteId) {
  return MaterialPageRoute(
      builder: (context) => BlocProvider<NoteCubit>(
            create: (context) => NoteCubit(
              notesRepository: sl(),
              saveNoteStrategy: UpdateNoteStrategy(
                sl(),
              ),
            )..iInitialise(noteId: noteId),
            child: NotePage(),
          ));
}
