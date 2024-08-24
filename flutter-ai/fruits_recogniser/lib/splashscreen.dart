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
      seconds: 15,
      navigateAfterSeconds: Home(),
      title: const Text(
        'Fruits Recogniser',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.blueAccent
        )
      ),
      image: Image.asset('assets/images/fruits.png'),
      backgroundColor: Colors.white,
      photoSize: 180,
      loaderColor: Colors.blueAccent,
      loadingText: const Text(
        'Auto-Code',
        style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 16
        )
      )
    );
  }
}
