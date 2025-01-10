import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:lakely/domain/entity/notes.dart';
import 'package:lakely/objectbox.g.dart';
import 'package:lakely/utils/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class NotesList extends StatelessWidget {
  const NotesList(
      {super.key,
      required this.notes,
      required this.isError,
      required this.isLoading,
      required this.onNoteTap,
      required this.onDelete});

  final List<Note> notes;
  final bool isError;
  final bool isLoading;
  final void Function(int) onNoteTap;
  final void Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return SliverFillRemaining(
        child: Center(
          child: Text("Error"),
        ),
      );
    }
    if (isLoading) {
      return SliverAnimatedList(
          initialItemCount: 15,
          itemBuilder: (context, index, animation) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: ListTile(
                tileColor: AppSettings.colors.cardColor,
                leading: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade300,
                    child: CircleAvatar()),
                title: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      width: double.infinity,
                      height: 12,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                    )),
                subtitle: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      width: double.infinity,
                      height: 12,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                    )),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            );
          });
    }
    return SliverList(
      delegate: SliverChildListDelegate([
        ...notes.map((note) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Slidable(
              key: Key(note.id.toString()),
              startActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      onDelete(note.id);
                    },
                    backgroundColor: Color(0xFFFF5449),
                    foregroundColor: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: ListTile(
                onTap: () => onNoteTap(note.id),
                tileColor: AppSettings.colors.cardColor,
                title: Text(note.title),
                subtitle: Text(DateFormat('EEE, dd/MMM/yyyy HH:mm')
                    .format(note.updatedAt)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          );
        }).toList()
      ]),
    );
  }
}
