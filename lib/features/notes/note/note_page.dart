import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/note.dart';
import 'package:note_app/dsm/snackbar.dart';
import 'package:note_app/features/notes/note/note_cubit/cubit.dart';

import '../../../dsm/na_page.dart';
import '../../../field_validators/field_validators.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late final TextEditingController titleController, bodyController;
  late final FocusNode nameFocusNode, bodyFocusNode;

  final _formKey = GlobalKey<FormState>();

  AutovalidateMode formValidationMode = AutovalidateMode.disabled;

  @override
  void initState() {
    titleController = TextEditingController();
    bodyController = TextEditingController();
    nameFocusNode = FocusNode();
    bodyFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NaPage(
      title: 'Add note',
      body: BlocConsumer<NoteCubit, NoteCubitState>(
        listener: (context, state) {
          if (state.status == NoteStatus.saved) {
            Future.delayed(Duration.zero, () {
              Navigator.pop(context, state.createdNote);
            });
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            autovalidateMode: formValidationMode,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                TextFormField(
                  controller: titleController,
                  focusNode: nameFocusNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (text) => bodyFocusNode.requestFocus(),
                  decoration: InputDecoration(label: Text('Title')),
                  validator: validateNotEmpty,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: bodyController,
                  focusNode: bodyFocusNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (text) => bodyFocusNode.requestFocus(),
                  decoration: InputDecoration(label: Text('Body')),
                ),
                SizedBox(height: 50),
                Center(
                  child: SizedBox(
                    width: 240,
                    child: ElevatedButton(
                      child: Text('Save'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<NoteCubit>().iCreateNote(
                                title: titleController.text,
                                body: bodyController.text,
                              );
                        } else {
                          showSnackBar(context, 'Fill all required data first');
                          setState(() {
                            formValidationMode =
                                AutovalidateMode.onUserInteraction;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
