import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lakely/domain/db/database.dart';
import 'package:lakely/states/apps_cubit/apps_cubit.dart';
import 'package:lakely/states/apps_cubit/apps_cubit.dart';

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
            if (state is LoadedAppState) {
              if (state.apps.isEmpty) {
                return Text("Приложения не найдены");
              } else {
                return GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: [
                    ...state.apps.map((app) => GestureDetector(
                          onTap: () => onIconTap(context, app.id),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 64,
                              width: 64,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: MemoryImage(app.icon)),
                              ),
                            ),
                          ),
                        ))
                  ],
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
