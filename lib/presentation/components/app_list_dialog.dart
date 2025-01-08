import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lakely/domain/entity/apps.dart';
import 'package:lakely/states/apps_cubit/apps_cubit.dart';
import 'package:lakely/utils/app_icons_cache_util.dart';
import 'package:lakely/utils/image_utils.dart';

class AppListDialog extends StatefulWidget {
  const AppListDialog({
    super.key,
    required this.onAppClick,
    required this.homeApps,
  });

  final Function(int) onAppClick;
  final List<App> homeApps;

  @override
  State<AppListDialog> createState() => _AppListDialogState();
}

class _AppListDialogState extends State<AppListDialog> {
  String searchQuery = "";

  void onIconTap(BuildContext context, int appId) {
    widget.onAppClick(appId);
    context.router.popForced();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(maxHeight: 400),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Поиск приложений',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  debugPrint("||| $state");
                  if (state is LoadedAppState) {
                    final filteredApps = state.apps
                        .where((app) =>
                        app.title.toLowerCase().contains(searchQuery))
                        .toList();

                    if (filteredApps.isEmpty) {
                      return const Center(
                        child: Text("Приложения не найдены"),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: filteredApps.length,
                      cacheExtent: 1000,
                      itemBuilder: (BuildContext context, int index) {
                        var app = filteredApps[index];
                        return GestureDetector(
                          onTap: () => onIconTap(context, app.id),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 64, maxHeight: 64),
                              child: Column(
                                children: [
                                  FutureBuilder(
                                    future: Future.microtask(() =>
                                        AppIconCacheUtil.getIcon(
                                            app.packageName)),
                                    builder: (context, snap) {
                                      return Stack(
                                        children: [
                                          SizedBox(
                                            width: 48,
                                            height: 48,
                                            child: snap.data != null
                                                ? Image.memory(
                                                widget.homeApps
                                                    .map((el) => el.id)
                                                    .contains(app.id)
                                                    ? ImageUtils
                                                    .convertToGrayscale(
                                                    snap.data!)
                                                    : snap.data!)
                                                : const CircularProgressIndicator(),
                                          ),
                                          if (widget.homeApps
                                              .map((el) => el.id)
                                              .contains(app.id))
                                            const SizedBox(
                                              width: 48,
                                              height: 48,
                                              child: Opacity(
                                                opacity: 0.6,
                                                child: Card(
                                                  child: Icon(Icons.delete),
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    app.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
