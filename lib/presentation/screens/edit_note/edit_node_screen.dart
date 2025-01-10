import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lakely/domain/db/objectbox.dart';
import 'package:lakely/domain/service/notes_service.dart';
import 'package:lakely/presentation/components/grid_painter.dart';
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
  final QuillController _controller = QuillController.basic();
  TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NoteBloc(NotesService(ServiceLocator.get<ObjectBox>().store))
            ..add(LoadNote(widget.id)),
      child: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state is NoteLoaded) {
            final note = state.note;

            // Устанавливаем заголовок, только если он отличается
            if (_titleController.text != note.title) {
              _titleController.text = note.title;
            }

            // Проверяем, совпадает ли содержимое
            final currentDelta =
                jsonEncode(_controller.document.toDelta().toJson());
            if (currentDelta != note.content) {
              // Обновляем документ в QuillController
              _controller.document = Document.fromJson(
                jsonDecode(note.content.isNotEmpty ? note.content : '[]'),
              );
              setState(() {}); // Обновляем виджет с новым контроллером
            }
          }
          if (state is NoteModified) {
            final note = state.note;

            // Устанавливаем заголовок, только если он отличается
            if (_titleController.text != note.title) {
              _titleController.text = note.title;
            }

            // Проверяем, совпадает ли содержимое
            final currentDelta =
                jsonEncode(_controller.document.toDelta().toJson());
            if (currentDelta != note.content) {
              // Обновляем документ в QuillController
              _controller.document = Document.fromJson(
                  jsonDecode(note.content.isNotEmpty ? note.content : '[]'),
                );
              setState(() {}); // Обновляем виджет с новым контроллером
            }
          }
        },
        builder: (context, state) {
          // _controller.addListener(() {
          //   debugPrint("########");
          //   // context.read<NoteBloc>().add(UpdateNote(_titleController.value.text,
          //   //     jsonEncode(_controller.document.toDelta().toJson())));
          // });
          if (state is NoteLoaded ||
              state is NoteEmpty ||
              state is NoteModified) {
            return CustomPaint(
              painter: GridPainter(),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: AppSettings.colors.cardColor,
                  title: Text("Блокнот"),
                  actions: [
                    if (state is NoteModified)
                      IconButton(
                          onPressed: () {
                            context.read<NoteBloc>().add(SaveNote());
                          },
                          icon: Icon(Icons.save_rounded)),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.share_rounded)),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
                  ],
                ),
                bottomNavigationBar: BottomAppBar(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppSettings.colors.cardColor),
                    padding: EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: QuillSimpleToolbar(
                        controller: _controller,
                        configurations:
                            const QuillSimpleToolbarConfigurations(),
                      ),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: TextField(
                          controller: _titleController,
                          onChanged: (value) => context.read<NoteBloc>().add(
                              UpdateNote(
                                  value,
                                  jsonEncode(_controller.document
                                      .toDelta()
                                      .toJson()))),
                          decoration: InputDecoration(
                            hintText: "Заголовок",
                            border: InputBorder.none,
                          ),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: 900),
                          child: QuillEditor.basic(
                            controller: _controller,
                            configurations: const QuillEditorConfigurations(
                              scrollPhysics: NeverScrollableScrollPhysics(),
                              scrollable: false,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text("ERROR"),
            );
          }
        },
      ),
    );
  }
}
