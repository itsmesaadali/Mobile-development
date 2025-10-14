import 'package:flutter/material.dart';
import 'flip_clock_page.dart';
import 'themes.dart';

class FlipClockApp extends StatelessWidget {
  const FlipClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flip Clock',
      theme: AppThemes.themes.first['theme'] as ThemeData,
      home: const FlipClockPage(),
    );
  }
}
