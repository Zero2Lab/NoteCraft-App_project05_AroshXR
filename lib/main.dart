import 'package:flutter/material.dart';
import 'package:project05/Screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'project 05',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
