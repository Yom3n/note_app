import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/note.dart';
import 'package:note_app/service_locator.dart';

import 'features/notes/note/note_cubit/cubit.dart';
import 'features/notes/note/note_page.dart';

MaterialPageRoute<Note> createNoteRoute() {
  return MaterialPageRoute(
      builder: (context) => BlocProvider(
            create: (context) => NoteCubit(sl()),
            child: NotePage(),
          ));
}