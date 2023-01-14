import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/service_locator.dart';

import 'features/notes/notes_page/bloc/notes_cubit/cubit.dart';
import 'features/notes/notes_page/notes_page.dart';

void main() {
  runApp(const MyApp());
  initializeServiceLocator();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => NotesCubit(sl())..iInitialise(),
        child: NotesPage(),
      ),
    );
  }
}
