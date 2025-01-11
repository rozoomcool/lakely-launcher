import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';
import 'package:intl/intl.dart';
import 'package:lakely/presentation/components/notes_list.dart';
import 'package:lakely/presentation/components/todo_card.dart';
import 'package:lakely/router/app_router.dart';
import 'package:lakely/states/notes_cubit/notes_cubit.dart';
import 'package:lakely/utils/app_colors.dart';
import 'package:lakely/utils/launch_apps.dart';
import 'package:lakely/utils/status_and_navigation_bar_color.dart';

@RoutePage()
class WorkScreen extends StatefulWidget {
  const WorkScreen({super.key});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {

  @override
  void initState() {
    super.initState();
    context.router.addListener(() {
      context.read<NotesCubit>().fetchNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    // setUiModeFullScreenImmersiveSticky();
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppSettings.colors.background,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppSettings.colors.cardColor,
                floating: false,
                pinned: true,
                expandedHeight: 130.0,
                stretch: true,
                actions: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.settings_rounded))
                ],
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  titlePadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  expandedTitleScale: 1.3,
                  title: Text("Блокнот"),
                ),
              ),
              NotesList(
                  notes: state is NotesLoaded ? state.notes : [],
                  isError: state is NotesError,
                  isLoading: state is NotesLoading,
                  onNoteTap: (int noteId) => context.router.push(EditNoteRoute(id: noteId)),
                  onDelete: (int noteId) => context.read<NotesCubit>().deleteNoteById(noteId),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.router.push(EditNoteRoute());
            },
            child: Icon(Icons.add_rounded),
          ),
          bottomNavigationBar: BottomAppBar(
            color: AppSettings.colors.background,
            child: Center(child: Text("Made by Daddy"),),
          ),
        );
      },
    );
  }
}

// BottomAppBar(
// color: AppSettings.colors.background,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// IconButton(
// onPressed: () {}, icon: Icon(Icons.view_list_rounded)),
// IconButton(
// onPressed: () {}, icon: Icon(Icons.grid_view_rounded)),
// IconButton(
// onPressed: () {}, icon: Icon(Icons.account_tree_rounded)),
// ],
// ),
// )