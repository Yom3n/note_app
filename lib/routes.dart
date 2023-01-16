import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/note.dart';
import 'package:note_app/service_locator.dart';

import 'features/notes/note/note_cubit/cubit.dart';
import 'features/notes/note/note_page.dart';

MaterialPageRoute<Note> createNoteRoute() {
  return MaterialPageRoute(
      builder: (context) => BlocProvider<BaseNoteCubit>(
            create: (context) => CreateNoteCubit(sl())..iInitialise(),
            child: NotePage(),
          ));
}

MaterialPageRoute<Note> editNoteRoute(int noteId) {
  return MaterialPageRoute(
      builder: (context) => BlocProvider<BaseNoteCubit>(
            create: (context) => EditNoteCubit(sl())..iInitialise(noteId),
            child: NotePage(),
          ));
}
