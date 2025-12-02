import 'package:flutter/material.dart';
import 'add_activity_screen.dart';
import 'activity_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SmartTracker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Add Activity"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddActivityScreen()),
                );
              },
            ),
            ElevatedButton(
              child: Text("Activity History"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ActivityListScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
