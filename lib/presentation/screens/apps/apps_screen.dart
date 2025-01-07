import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:lakely/states/apps_cubit/apps_cubit.dart';

@RoutePage()
class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
        switch (state) {
          case LoadedAppState:
            state as LoadedAppState;
            return ListView(
              shrinkWrap: true,
              children: state.apps.toSet().map((el) {
                    return Row(
                      children: [
                        SizedBox(
                            width: 36,
                            height: 36,
                            child: Image.memory(el.icon ?? Uint8List(0))),
                        Text(
                          el.title ?? "",
                          style: TextStyle(fontSize: 8),
                        ),
                      ],
                    );
                  }).toList() ??
                  [],
            );
          default:
            return SizedBox();
        }
      }),
    );
  }
}
