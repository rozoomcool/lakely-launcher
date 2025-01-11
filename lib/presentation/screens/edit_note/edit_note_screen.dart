import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lakely/domain/db/objectbox.dart';
import 'package:lakely/domain/entity/notes.dart';
import 'package:lakely/domain/service/notes_service.dart';
import 'package:lakely/presentation/components/grid_painter.dart';
import 'package:lakely/presentation/screens/edit_note/edit_note_screen_child.dart';
import 'package:lakely/states/note/note_bloc.dart';
import 'package:lakely/utils/app_colors.dart';
import 'package:lakely/utils/service_locator.dart';

@RoutePage()
class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key, this.id});

  final int? id;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NoteBloc(NotesService(ServiceLocator.get<ObjectBox>().store))
            ..add(LoadNote(widget.id)),
      child: EditNoteScreenChild(),
    );
  }
}
