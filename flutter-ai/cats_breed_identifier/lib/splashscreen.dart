import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
        'Cat Breed Identifier',
        style: TextStyle(
          fontFamily: 'Schyler', // Signatra
          fontWeight: FontWeight.bold,
          fontSize: 40,
          color: Colors.pink,
        )
      ),
      image: Image.asset('assets/images/icon.jpg'),
      backgroundColor: Colors.white,
      photoSize: 180,
      loaderColor: Colors.red,
      loadingText: Text(
        "Auto-Code",
        style: TextStyle(
          color: Colors.pinkAccent,
          fontSize: 16.0,
          fontFamily: 'Schyler', // Brand Bold
        )
      )

    );
  }
}
