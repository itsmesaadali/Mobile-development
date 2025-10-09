import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'list_screen.dart';
import 'about_screen.dart';

void main() {
  runApp(const TravelGuideApp());
}

class TravelGuideApp extends StatefulWidget {
  const TravelGuideApp({super.key});

  @override
  State<TravelGuideApp> createState() => _TravelGuideAppState();
}

class _TravelGuideAppState extends State<TravelGuideApp> {
  int _selectedIndex = 0;

  // List of screens for BottomNavigationBar
  final List<Widget> _screens = const [
    HomeScreen(),
    ListScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Guide',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Travel Guide'),
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(child: _screens[_selectedIndex]),

        // 🔹 Bottom navigation bar for switching screens
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.teal,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
          ],
        ),
      ),
    );
  }
}
