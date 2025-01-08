import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';
import 'package:intl/intl.dart';
import 'package:lakely/presentation/components/todo_card.dart';
import 'package:lakely/states/notes_cubit/notes_cubit.dart';
import 'package:lakely/utils/app_colors.dart';
import 'package:lakely/utils/launch_apps.dart';
import 'package:lakely/utils/status_and_navigation_bar_color.dart';

@RoutePage()
class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    setUiModeFullScreenImmersiveSticky();
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
              if (state is NotesLoaded)
                SliverAnimatedList(
                    initialItemCount: state.notes.length,
                    itemBuilder: (context, index, animation) {
                      var note = state.notes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: ListTile(
                          tileColor: AppSettings.colors.cardColor,
                          title: Text(note.title),
                          subtitle: Text(DateFormat('EEE, dd/MMM/yyyy HH:mm')
                              .format(note.updatedAt)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      );
                    })
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add_rounded),
          ),
          bottomNavigationBar: BottomAppBar(
            color: AppSettings.colors.background,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.view_list_rounded)),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.grid_view_rounded)),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.account_tree_rounded)),
              ],
            ),
          ),
        );
      },
    );
  }
}
