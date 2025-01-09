import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lakely/presentation/components/grid_painter.dart';
import 'package:lakely/utils/app_colors.dart';

@RoutePage()
class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Блокнот"),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.share_rounded)),
            IconButton(onPressed: () {}, icon: Icon(Icons.brush_rounded)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.all(8.0),
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppSettings.colors.cardColor
            ),
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: QuillSimpleToolbar(
                controller: _controller,
                configurations: const QuillSimpleToolbarConfigurations(),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
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
  }
}