import 'package:flutter/material.dart';
import 'package:tracks/screens/tracks_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.pinkAccent,
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: TracksScreen(),
    );
  }
}
