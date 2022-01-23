import 'package:flutter/material.dart';
import 'package:sketching/screens/index.dart';

// Sketching app for Flutter!
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sketching App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: const SketchingScreen(),
    );
  }
}
