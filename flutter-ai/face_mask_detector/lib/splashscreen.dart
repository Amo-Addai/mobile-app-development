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
      seconds: 15,
      navigateAfterSeconds: const Home(),
      title: const Text(
        'Face Mask Detector',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black
        )
      ),
      image: Image.asset('assets/splash.png'),
      photoSize: 130,
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
      loadingText: const Text(
        "Auto-Code",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16
        )
      ),

    );
  }
}
