import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:lakely/presentation/components/app_list_dialog.dart';
import 'package:lakely/states/apps_cubit/apps_cubit.dart';
import 'package:lakely/states/home_apps/home_apps_cubit.dart';
import 'package:lakely/utils/app_icons_cache_util.dart';

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
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4),
                    itemCount: homeAppsState.homeApps.length,
                    itemBuilder: (BuildContext context, int index) {
                      var app = homeAppsState.homeApps[index];
                      return GestureDetector(
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

// Wrap(
// children: [
// ...List.generate(8, (i) => Container(
// height: 64,
// width: 64,
// margin: EdgeInsets.all(8),
// color: Colors.amber,
// ))
// ],
// )
