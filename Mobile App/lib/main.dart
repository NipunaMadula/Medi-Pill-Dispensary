import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medipill/Bill.dart';
import 'package:medipill/Login.dart';
import 'package:medipill/home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Regedter(),
      routes: {

        '/second':(context)=>Bill(),
        '/home':(context)=>HomeScreen(),



      },
    );
  }
}

