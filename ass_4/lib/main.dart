import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(SmartTracker());
}

class SmartTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SmartTracker",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
