import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/service_locator.dart';

import 'features/manage_note/note_cubit/cubit.dart';
import 'features/manage_note/note_page.dart';
import 'models/note.dart';

MaterialPageRoute<Note> createNoteRoute() {
  return MaterialPageRoute(
      builder: (context) => BlocProvider<NoteCubit>(
            create: (context) => NoteCubit(
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
              saveNoteStrategy: UpdateNoteStrategy(
                sl(),
              ),
            )..iInitialise(noteId: noteId),
            child: NotePage(),
          ));
}
