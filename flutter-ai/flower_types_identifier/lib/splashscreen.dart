import 'package:flutter/material.dart';
// import 'package:splashscreen/splashscreen.dart';

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
      seconds: 5,
      navigateAfterSeconds: Home(),
      title: const Text(
        'Flower Types Recognizer',
        style: TextStyle(
          fontFamily: 'Schyler', // Signatra
          fontWeight: FontWeight.bold,
          fontSize: 40,
          color: Colors.black87,
        )
      ),
      image: Image.asset('assets/images/flowers.png'), // TODO: ensure in assets/images/
      backgroundColor: Colors.white,
      photoSize: 180,
      loaderColor: Colors.black87
    );
  }
}
