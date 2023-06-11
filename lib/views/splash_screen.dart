import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_app/utils/component/navigator.dart';
import 'package:note_app/views/notes_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  void _splashDelay() {
    _timer = Timer(const Duration(seconds: 4), _nextScreen);
  }

  void _nextScreen() {
    navigateToPushReplacement(context, const NotesScreen());
  }

  @override
  void initState() {
    super.initState();
    _splashDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          width: 260,
          image: AssetImage("assets/images/logo_transparent.png"),
        ),
      ),
    );
  }
}
