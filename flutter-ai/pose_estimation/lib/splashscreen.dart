import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: Home(),
      title: const Text(
        'Auto-Code',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.black
        )
      ),
      image: Image.asset('assets/images/icon.png'),
      backgroundColor: Colors.white,
      photoSize: 60,
      loaderColor: Colors.black
    );
  }
}
