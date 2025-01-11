import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lakely/domain/db/objectbox.dart';
import 'package:lakely/domain/entity/notes.dart';
import 'package:lakely/domain/service/notes_service.dart';
import 'package:lakely/presentation/components/grid_painter.dart';
import 'package:lakely/states/note/note_bloc.dart';
import 'package:lakely/utils/app_colors.dart';
import 'package:lakely/utils/service_locator.dart';

class EditNoteScreenChild extends StatefulWidget {
  const EditNoteScreenChild({super.key});

  @override
  State<EditNoteScreenChild> createState() => _EditNoteScreenChildState();
}

class _EditNoteScreenChildState extends State<EditNoteScreenChild> {
  final QuillController _quillController = QuillController.basic();
  final TextEditingController _titleController = TextEditingController();
  String? _previousContent;

  @override
  void initState() {
    super.initState();
    _addQuillControllerListener();
  }

  @override
  void dispose() {
    _quillController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _addQuillControllerListener() {
    _quillController.addListener(() {
      final currentContent =
          jsonEncode(_quillController.document.toDelta().toJson());
      _previousContent ??= currentContent;
      if (_previousContent != currentContent) {
        _previousContent = currentContent;
        context.read<NoteBloc>().add(
              UpdateNote(
                _titleController.text,
                currentContent,
              ),
            );
      }
    });
  }

  void _updateNote(Note note) {
    // Устанавливаем заголовок, только если он отличается
    if (_titleController.text != note.title) {
      _titleController.text = note.title;
    }

    // Проверяем, совпадает ли содержимое
    final currentDelta =
        jsonEncode(_quillController.document.toDelta().toJson());
    if (currentDelta != note.content) {
      _quillController.document = Document.fromJson(
        jsonDecode(note.content.isNotEmpty ? note.content : '[]'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      listener: (context, state) {
        if (state.note != null) {
          _updateNote(state.note!);
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.error != null) {
          return Center(child: Text(state.error!.message ?? "Ошибка"));
        }

          return CustomPaint(
            painter: GridPainter(),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: AppSettings.colors.cardColor,
                title: const Text("Блокнот"),
                actions: [
                  if (state.isModified)
                    IconButton(
                      onPressed: () {
                        context.read<NoteBloc>().add(SaveNote());
                      },
                      icon: const Icon(Icons.save_rounded),
                    ),
                  IconButton(
                    onPressed: () {}, // Поделиться
                    icon: const Icon(Icons.share_rounded),
                  ),
                  IconButton(
                    onPressed: () {}, // Дополнительные действия
                    icon: const Icon(Icons.more_vert_rounded),
                  ),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                padding: const EdgeInsets.all(8.0),
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppSettings.colors.cardColor,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: QuillSimpleToolbar(
                      controller: _quillController,
                      configurations: const QuillSimpleToolbarConfigurations(),
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      onChanged: (value) {
                        context.read<NoteBloc>().add(
                              UpdateNote(
                                value,
                                jsonEncode(_quillController.document
                                    .toDelta()
                                    .toJson()),
                              ),
                            );
                      },
                      decoration: const InputDecoration(
                        hintText: "Заголовок",
                        border: InputBorder.none,
                      ),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Expanded(
                      child: QuillEditor.basic(
                        controller: _quillController,
                        configurations: const QuillEditorConfigurations(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

      },
    );
  }
}
