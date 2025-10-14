import 'package:flutter/material.dart';

class AppThemes {
  static final List<Map<String, dynamic>> themes = [
    {
      'name': 'Dark Blue',
      'theme': ThemeData(
        primaryColor: Colors.blue[900],
        scaffoldBackgroundColor: Colors.blueGrey[900],
        cardColor: Colors.blue[800],
        colorScheme: ColorScheme.dark(
          primary: Colors.blue,
          secondary: Colors.blueAccent,
        ),
      ),
    },
    {
      'name': 'Dark Green',
      'theme': ThemeData(
        primaryColor: Colors.green[900],
        scaffoldBackgroundColor: Colors.teal[900],
        cardColor: Colors.green[800],
        colorScheme: ColorScheme.dark(
          primary: Colors.green,
          secondary: Colors.tealAccent,
        ),
      ),
    },
    {
      'name': 'Pure Black',
      'theme': ThemeData(
        primaryColor: const Color(0xFF000000),
        scaffoldBackgroundColor: const Color(0xFF000000),
        cardColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF000000),
          secondary: Colors.white70,
        ),
      ),
    },

    {
      'name': 'Matte Black',
      'theme': ThemeData(
        primaryColor: const Color(0xFF1C1C1C),
        scaffoldBackgroundColor: const Color(0xFF1C1C1C),
        cardColor: const Color(0xFF2A2A2A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF1C1C1C),
          secondary: Colors.white60,
        ),
      ),
    },
  ];
}
