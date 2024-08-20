import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:cats_vs_dogs/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen(
      {super.key,
      required int seconds,
      required Home navigateAfterSeconds,
      required Text title,
      required Image image,
      required MaterialAccentColor backgroundColor,
      required int photoSize,
      required Color loaderColor});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return const SplashScreen(
      seconds: 2,
      navigateAfterSeconds: Home(),
      title: Text('Cat and Dog Classifier',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Color(0x00FFFF))),
      image: Image.asset('assets/cat_dog_icon.png'),
      backgroundColor: Colors.blueAccent,
      photoSize: 60,
      loaderColor: Color(0x004242),
    );
  }
}
