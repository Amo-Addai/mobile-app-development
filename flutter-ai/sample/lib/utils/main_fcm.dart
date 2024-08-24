import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'video_call_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Handle background message
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VideoCallScreen(message.data['token'])),
        );
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      // Show in-app notification and handle call accept/deny
      if (message.notification != null) {
        _showNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VideoCallScreen(message.data['token'])),
      );
    });
  }

  void _showNotification(RemoteMessage message) {
    // Display notification with options to accept/deny
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call App'),
      ),
      body: Center(
        child: Text('Waiting for call...'),
      ),
    );
  }
}
