import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:take_home/auth_home_decider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Take Home',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const AuthHomeDecider(),
    );
  }
}
