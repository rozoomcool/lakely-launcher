import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:lakely/domain/db/objectbox.dart';
import 'package:lakely/states/apps_cubit/apps_cubit.dart';
import 'package:lakely/states/apps_cubit/apps_cubit.dart';
import 'package:lakely/utils/app_icons_cache_util.dart';

class AppListDialog extends StatelessWidget {
  const AppListDialog({super.key, required this.onAppClick});

  final Function(int) onAppClick;

  void onIconTap(BuildContext context, int appId) {
    onAppClick(appId);
    context.router.popForced();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        constraints: BoxConstraints(maxHeight: 350),
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            debugPrint("||| $state");
            if (state is LoadedAppState) {
              if (state.apps.isEmpty) {
                return Text("Приложения не найдены");
              } else {
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: state.apps.length,
                  cacheExtent: 1000,
                  itemBuilder: (BuildContext context, int index) {
                    var app = state.apps[index];
                    return GestureDetector(
                      onTap: () => onIconTap(context, app.id),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 64, maxHeight: 64),
                          child: Column(
                            children: [
                              FutureBuilder(
                                  future: Future.microtask(() =>
                                      AppIconCacheUtil.getIcon(
                                          app.packageName)),
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
                                app.title,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
