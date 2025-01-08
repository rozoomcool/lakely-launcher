import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:lakely/presentation/components/app_list_dialog.dart';
import 'package:lakely/states/apps_cubit/apps_cubit.dart';
import 'package:lakely/states/home_apps/home_apps_cubit.dart';
import 'package:lakely/utils/app_icons_cache_util.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class HomeAppsList extends StatelessWidget {
  const HomeAppsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<HomeAppsCubit, HomeAppsState>(
              builder: (context, homeAppsState) {
            debugPrint("|||| $homeAppsState");
            if (homeAppsState is LoadedHomeAppsState) {
              return Column(
                children: [
                  Center(
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AppListDialog(
                                      onAppClick: (appId) => context
                                          .read<HomeAppsCubit>()
                                          .addHomeApp(appId));
                                });
                            // showAboutDialog(context: context);
                          },
                          child: Text("Добавить приложения"))),
                  ReorderableGridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4),
                    itemCount: homeAppsState.homeApps.length,
                    itemBuilder: (BuildContext context, int index) {
                      var app = homeAppsState.homeApps[index];
                      return GestureDetector(
                        key: Key(app.position.toString()),
                        onTap: () {
                          context.read<HomeAppsCubit>().deleteHomeApp(app.id);
                        },
                        child: Column(
                          children: [
                            FutureBuilder(
                                future: Future.microtask(() =>
                                    AppIconCacheUtil.getIcon(
                                        app.app.packageName)),
                                builder: (context, snap) {
                                  return SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: snap.data != null
                                        ? Image.memory(snap.data!)
                                        : const CircularProgressIndicator(),
                                  );
                                }),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              app.app.title,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ],
                        ),
                      );
                    }, onReorder: (int oldIndex, int newIndex) {
                      context.read<HomeAppsCubit>().reorderHomeApps(oldIndex, newIndex);
                  },
                  ),
                ],
              );
            } else {
              return SizedBox();
            }
          }),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class ReorderableGridViewExample extends StatefulWidget {
//   @override
//   _ReorderableGridViewExampleState createState() => _ReorderableGridViewExampleState();
// }
//
// class _ReorderableGridViewExampleState extends State<ReorderableGridViewExample> {
//   List<String> items = List.generate(10, (index) => 'Item $index');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Reorderable GridView")),
//       body: ReorderableGridView(
//         items: items,
//         onReorder: (oldIndex, newIndex) {
//           setState(() {
//             if (newIndex > oldIndex) {
//               newIndex -= 1;
//             }
//             final item = items.removeAt(oldIndex);
//             items.insert(newIndex, item);
//           });
//         },
//       ),
//     );
//   }
// }

// class ReorderableGridView extends StatelessWidget {
//   final List<String> items;
//   final void Function(int oldIndex, int newIndex) onReorder;
//
//   const ReorderableGridView({
//     required this.items,
//     required this.onReorder,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
