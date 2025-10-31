import 'package:final_project/ui/get_started.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather App',
      home: GetStarted(),
      debugShowCheckedModeBanner: false,
    );
  }
}
