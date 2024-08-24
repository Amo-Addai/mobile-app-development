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
      seconds: 2,
      navigateAfterSeconds: Home(),
      title: const Text('Cat and Dog Classifier',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.yellowAccent
          )
      ),
      image: Image.asset('assets/cat_dog_icon.png'),
      backgroundColor: Colors.blueAccent,
      photoSize: 60,
      loaderColor: Colors.redAccent,
    );
  }
}
