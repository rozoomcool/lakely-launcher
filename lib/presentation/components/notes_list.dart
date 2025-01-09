import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lakely/domain/entity/notes.dart';
import 'package:lakely/utils/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class NotesList extends StatelessWidget {
  const NotesList(
      {super.key,
      required this.notes,
      required this.isError,
      required this.isLoading});

  final List<Note> notes;
  final bool isError;
  final bool isLoading;

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
    return SliverAnimatedList(
        initialItemCount: notes.length,
        itemBuilder: (context, index, animation) {
          var note = notes[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: ListTile(
              tileColor: AppSettings.colors.cardColor,
              title: Text(note.title),
              subtitle: Text(
                  DateFormat('EEE, dd/MMM/yyyy HH:mm').format(note.updatedAt)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          );
        });
  }
}
