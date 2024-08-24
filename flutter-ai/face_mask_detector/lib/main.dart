import 'package:flutter/material.dart';
import 'package:face_mask_detector/splashscreen.dart';
import 'package:camera/camera.dart';


List<CameraDescription>? cameras;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Face-Mask Detector',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
