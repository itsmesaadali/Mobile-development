import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.indigo,
  scaffoldBackgroundColor: const Color(0xFFF6F8FB),
  cardTheme: CardThemeData(
    elevation: 4,
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 14.0),
  ),
);
