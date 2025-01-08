import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lakely/domain/service/apps_service.dart';
import 'package:lakely/domain/service/home_apps_service.dart';
import 'package:lakely/router/app_router.dart';
import 'package:lakely/states/apps_cubit/apps_cubit.dart';
import 'package:lakely/states/home_apps/home_apps_cubit.dart';
import 'package:lakely/utils/app_colors.dart';
import 'package:lakely/utils/service_locator.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                AppCubit(AppsService(ServiceLocator.get()))..init()),
        BlocProvider(
            create: (context) =>
                HomeAppsCubit(HomeAppsService(ServiceLocator.get()))..init())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme:
                GoogleFonts.aBeeZeeTextTheme(Theme.of(context).textTheme)),
        darkTheme: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.fromSeed(
                brightness: Brightness.dark,
                seedColor: AppSettings.colors.primary),
            textTheme: GoogleFonts.jetBrainsMonoTextTheme().apply(
              displayColor: Color(0xFFFDFDFD),
              bodyColor: Color(0xFFFDFDFD),
            ),
            dialogTheme: DialogTheme.of(context).copyWith(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: AppSettings.colors.cardColor,
            ),
            cardTheme: CardTheme.of(context).copyWith(
                color: AppSettings.colors.cardColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            scaffoldBackgroundColor: Colors.black),
        themeMode: ThemeMode.dark,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}

// ColorScheme.fromSeed(
// brightness: Brightness.dark,
// seedColor: Color(0xff1cbeda),
// surface: AppColors.backgroundDark,
// surfaceContainer: AppColors.backgroundDark,
//
// )

// ColorScheme.fromSwatch(
// brightness: Brightness.dark,
// primary: Color(0xff008D8F),
// secondary: Color(0xFF7F9595),
// tertiary: Color(0xFF8292AB),
// error: Color(0xFFFF5449),
// surface: Color(0xFF8F9191),
// onPrimary: Colors.white.withAlpha(30),
// onSecondary: Colors.white.withAlpha(30),
// onError: Colors.white.withAlpha(30),
// onSurface: Colors.white.withAlpha(30),
// )
