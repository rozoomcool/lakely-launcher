import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lakely/presentation/components/app_list_dialog.dart';
import 'package:lakely/states/apps_cubit/apps_cubit.dart';
import 'package:lakely/states/home_apps/home_apps_cubit.dart';

class HomeAppsList extends StatelessWidget {
  const HomeAppsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return BlocBuilder<HomeAppsCubit, HomeAppsState>(
            builder: (context, homeAppsState) {
              debugPrint("|||| $homeAppsState");
              if (homeAppsState is LoadedHomeAppsState) {
                if (homeAppsState.homeApps.isEmpty) {
                  return Center(
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                  return AppListDialog(onAppClick: (appId) => context.read<HomeAppsCubit>().addHomeApp(appId));
                                }
                            );
                            // showAboutDialog(context: context);
                          },
                          child: Text("Добавить приложения")));
                }
                return Container(
                  // height: 176,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    children: [
                      ...homeAppsState.homeApps.map(
                              (app) =>
                              GestureDetector(
                                onTap: () {context.read<HomeAppsCubit>().deleteHomeApp(app.id);},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 64,
                                    width: 64,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          image: MemoryImage(app.app.icon)),
                                    ),
                                  ),
                                ),
                              ))
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            });
      },
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
