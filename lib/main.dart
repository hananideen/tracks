import 'package:flutter/material.dart';
import 'package:tracks/screens/tracks_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: TracksScreen(),
    );
  }
}
