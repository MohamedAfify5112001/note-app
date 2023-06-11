import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/bloc/note_bloc.dart';
import 'package:note_app/themes.dart';
import 'package:note_app/views/splash_screen.dart';

class MyApp extends StatelessWidget {
  MyApp._internal();

  static MyApp get instance => MyApp._internal();

  factory MyApp() => instance;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return BlocProvider(
          create: (context) => NoteBloc(),
          child: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.watch<NoteBloc>().isDark
                    ? AppTheme.dark()
                    : AppTheme.light(),
                home: const SplashScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
