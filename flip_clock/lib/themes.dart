import 'package:flutter/material.dart';

class AppThemes {
  static final List<Map<String, dynamic>> themes = [
    {
      'name': 'Dark Blue',
      'theme': ThemeData(
        primaryColor: Colors.blue[900],
        scaffoldBackgroundColor: Colors.blueGrey[900],
        cardColor: Colors.blue[800],
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.blue[900]!,
          secondary: Colors.blue[700]!,
        ),
      ),
    },
    {
      'name': 'Dark Purple',
      'theme': ThemeData(
        primaryColor: Colors.purple[900],
        scaffoldBackgroundColor: Colors.deepPurple[900],
        cardColor: Colors.purple[800],
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.purple[900]!,
          secondary: Colors.purple[700]!,
        ),
      ),
    },
    {
      'name': 'Dark Green',
      'theme': ThemeData(
        primaryColor: Colors.green[900],
        scaffoldBackgroundColor: Colors.teal[900],
        cardColor: Colors.green[800],
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.green[900]!,
          secondary: Colors.green[700]!,
        ),
      ),
    },
  ];
}
