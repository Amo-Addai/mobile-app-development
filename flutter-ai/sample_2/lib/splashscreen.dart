import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const SplashScreen(
        seconds: 2,
        navigateAfterSeconds: Home(),
        title: Text(
            'Cat and Dog Classifier',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color(0x00FFFF)
            )
        )
    );
  }
}
