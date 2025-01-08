import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lakely/app/app.dart';
import 'package:lakely/states/apps_cubit/apps_cubit.dart';
import 'package:lakely/utils/service_locator.dart';
import 'package:lakely/utils/status_and_navigation_bar_color.dart';

import 'domain/db/objectbox.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  darkStatusAndNavigationBar();
  final objectbox = await ObjectBox.create();
  ServiceLocator.register(objectbox);

  runApp(const MainApp());
}

// dart run drift_dev analyze
// dart run drift_dev identify-databases
// dart run drift_dev schema dump lib/domain/db/objectbox.dart schema.json