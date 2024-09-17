import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_management/logic/locator.dart';
import 'package:library_management/ui/screen_selector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCBwOe06KM1f52P5e_Ea1GiFk8z2mILF6g",
          authDomain: "demolib-e848d.firebaseapp.com",
          projectId: "demolib-e848d",
          storageBucket: "demolib-e848d.appspot.com",
          messagingSenderId: "3072658131",
          appId: "1:3072658131:web:b0f45d2f5ec8b9056f2226",
          measurementId: "G-0SJZ84JCX8"));
  Locator.setup();
  await Locator.startupService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Library",
      home: ScreenSelector(),
      debugShowCheckedModeBanner: false,
    );
  }
}
