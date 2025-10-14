import 'package:flutter/material.dart';
import 'flip_clock_page.dart';
import 'stopwatch_page.dart';
import 'themes.dart';

class FlipClockApp extends StatefulWidget {
  const FlipClockApp({super.key});

  @override
  State<FlipClockApp> createState() => _FlipClockAppState();
}

class _FlipClockAppState extends State<FlipClockApp> {
  int _selectedIndex = 0;
  int _selectedThemeIndex = 0;

  void _changeTheme(int index) {
    setState(() => _selectedThemeIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppThemes.themes[_selectedThemeIndex]['theme'] as ThemeData;

    final pages = [
      FlipClockPage(
        onThemeChanged: _changeTheme,
        themeIndex: _selectedThemeIndex,
      ),
      StopwatchPage(
        onThemeChanged: _changeTheme,
        themeIndex: _selectedThemeIndex,
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: theme.scaffoldBackgroundColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              label: 'Clock',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Stopwatch',
            ),
          ],
        ),
      ),
    );
  }
}
