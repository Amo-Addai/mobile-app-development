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
      navigateAfterSeconds: Home(),
      title: const Text(
        'Dog Breed Identifier',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.pink,
        )
      ),
      image: Image.asset('assets/images/dog.png'),
      photoSize: 180,
      backgroundColor: Colors.white,
      loaderColor: Colors.red,
      loaderText: Text(
        "Auto-Code",
        style: TextStyle(
          color: Colors.pinkAccent,
          fontSize: 16
        )
      )
    );
  }
}
