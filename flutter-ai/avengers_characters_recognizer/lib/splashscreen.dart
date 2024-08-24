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
        'Avengers',
        style: TextStyle(
          fontFamily: 'Schyler', // Signatra
          fontWeight: FontWeight.bold,
          fontSize: 80,
          color: Colors.pink,
        )
      ),
      image: Image.asset('assets/images/icon.png'), // TODO: ensure in assets/images/
      backgroundColor: Colors.white,
      photoSize: 180,
      loaderColor: Colors.red,
      loadingText: Text(
        'Auto-Code',
        style: TextStyle(
          fontFamily: 'Schyler', // Brand Bold
          color: Colors.pinkAccent,
          fontSize: 16
        )
      )
    );
  }
}
