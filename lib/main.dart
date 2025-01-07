import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lakely/app/app.dart';
import 'package:lakely/states/apps_cubit/apps_cubit.dart';
import 'package:lakely/utils/service_locator.dart';
import 'package:lakely/utils/status_and_navigation_bar_color.dart';

import 'domain/db/database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  darkStatusAndNavigationBar();
  final database = AppDatabase();
  ServiceLocator.register(database);

  runApp(const MainApp());
}

// dart run drift_dev schema dump lib/domain/db/database.dart schema.json