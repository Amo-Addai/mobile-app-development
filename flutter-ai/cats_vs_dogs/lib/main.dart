import 'package:flutter/material.dart';

import 'splashscreen.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat and Dog Classifier',
      home: SplashScreen(
          seconds: 2,
          navigateAfterSeconds: Home(),
          title: Text('Cat and Dog Classifier'),
          image: Image.asset('assets/cat_dog_icon.png'),
          backgroundColor: Colors.blueAccent,
          photoSize: 60,
          loaderColor: Color(0x004242)),
      debugShowCheckedModeBanner: false,
    );
  }
}
