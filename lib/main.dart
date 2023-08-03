import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/emailAuth/login.dart';

// Import the flutter_localizations package
// Import the flutter_localizations package
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyD63dLyMfZV-F2yOmsbLKW1ENxOGrhiicA',
            appId: '1:139906491197:web:481059d3d678c7a71e5b54',
            messagingSenderId: '139906491197',
            projectId: 'instagram-clone-7f9dc',
            storageBucket: 'instagram-clone-7f9dc.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intagram Clone',
      theme: ThemeData.dark(),
      home: ResponsiveLayout(
          mobileScreenLayout: FirebaseAuth.instance.currentUser != null
              ? const MobileScreenLayout()
              : EmailLogin(),
          webScreenLayout: const WebScreenLayout()),
    );
  }
}