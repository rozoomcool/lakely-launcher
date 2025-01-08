import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:lakely/domain/entity/apps.dart';
import 'package:lakely/presentation/components/app_list_dialog.dart';
import 'package:lakely/states/apps_cubit/apps_cubit.dart';
import 'package:lakely/states/home_apps/home_apps_cubit.dart';
import 'package:lakely/utils/app_icons_cache_util.dart';
import 'package:lakely/utils/image_utils.dart';
import 'package:lakely/utils/launch_apps.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class HomeAppsList extends StatelessWidget {
  const HomeAppsList({super.key});

  void openAppListDialog(BuildContext context, List<App> homeApps) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppListDialog(
            onAppClick: (appId) {
              if (homeApps.map((el) => el.id).contains(appId)) {
                return context.read<HomeAppsCubit>().deleteHomeAppByAppId(appId);
              } else {
                return context.read<HomeAppsCubit>().addHomeApp(appId);
              }
            },
            homeApps: homeApps,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: BlocBuilder<HomeAppsCubit, HomeAppsState>(
              builder: (context, homeAppsState) {
            debugPrint("|||| $homeAppsState");
            if (homeAppsState is LoadedHomeAppsState) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Мои приложения",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 12.0,
                        children: [
                          IconButton(
                              onPressed: () => openAppListDialog(
                                  context,
                                  homeAppsState.homeApps
                                      .map((el) => el.app)
                                      .toList()),
                              icon: Icon(Icons.edit_rounded)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 144),
                    child: ReorderableGridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4),
                      itemCount: homeAppsState.homeApps.length,
                      onReorder: (int oldIndex, int newIndex) {
                        context
                            .read<HomeAppsCubit>()
                            .reorderHomeApps(oldIndex, newIndex);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        var app = homeAppsState.homeApps[index];
                        return GestureDetector(
                          key: Key(app.position.toString()),
                          onTap: () {

                            launchApp(app.app.packageName);
                          },
                          child: Column(
                            children: [
                              FutureBuilder(
                                  future: Future.microtask(() =>
                                      AppIconCacheUtil.getIcon(
                                          app.app.packageName)),
                                  builder: (context, snap) {
                                    return Container(
                                      color: Colors.transparent,
                                      constraints:
                                          BoxConstraints(maxHeight: 48),
                                      child: snap.data != null
                                          ? Image.memory(
                                              ImageUtils.convertToGrayscale(snap.data!),
                                            )
                                          : const CircularProgressIndicator(),
                                    );
                                  }),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                app.app.title,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelSmall,
                              )
                            ],
                          ),
                        );
                      },
                    ),
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
