// main.dart
import 'package:flutter/material.dart';
import 'splash_screen.dart'; // import splash screen

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Start from splash screen
    ),
  );
}
