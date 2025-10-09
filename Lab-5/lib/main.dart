// main.dart

import 'package:flutter/material.dart';
// ✅ Import your BoxDoc.dart file
import 'BoxDoc.dart';

void main() {
  runApp(const MainApp());
}

// 🔹 Root widget of the app
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Widget Tree')),
        body: const SafeAreaWidget(),
      ),
    );
  }
}

// 🔹 SafeArea prevents UI from overlapping with notches or status bar
class SafeAreaWidget extends StatelessWidget {
  const SafeAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: SignleChildScrollViewWidget());
  }
}

// 🔹 Allows scrolling if content is long
class SignleChildScrollViewWidget extends StatelessWidget {
  const SignleChildScrollViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(child: PaddingWdiget());
  }
}

// 🔹 Adds padding and contains the column layout
class PaddingWdiget extends StatelessWidget {
  const PaddingWdiget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInstetsWidget(),
      child: Column(
        children: <Widget>[
          // 🔸 First Row with three containers
          Row(
            children: <Widget>[
              const ContainerWidget(),
              Padding(padding: EdgeInstetsWidget()),
              const ExpandedWidget(),
              Padding(padding: EdgeInstetsWidget()),
              Container(color: Colors.brown, height: 40.0, width: 40.0),
            ],
          ),
          Padding(padding: EdgeInstetsWidget()),

          // 🔸 Second Row with a Column inside
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(color: Colors.yellow, height: 60.0, width: 60.0),
                  Padding(padding: EdgeInstetsWidget()),
                  Container(color: Colors.amber, height: 40.0, width: 40.0),
                  Padding(padding: EdgeInstetsWidget()),
                  Container(color: Colors.brown, height: 20.0, width: 20.0),

                  const Divider(),
                  const RowWidget(),
                  const Divider(),

                  const Text('End of the Line'),

                  // ✅ Imported widget from BoxDoc.dart
                  const SizedBox(height: 20),
                  const ContainerWithBoxDecorationWidget(), // 👈 This is from BoxDoc.dart
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🔹 Helper method for consistent padding
  EdgeInsets EdgeInstetsWidget() => const EdgeInsets.all(16.0);
}

// 🔹 Simple container widget
class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.yellow, height: 40.0, width: 40.0);
  }
}

// 🔹 Expanded widget fills remaining horizontal space
class ExpandedWidget extends StatelessWidget {
  const ExpandedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(color: Colors.amber, height: 40.0, width: 40.0),
    );
  }
}

// 🔹 Row widget with a CircleAvatar and stacked containers
class RowWidget extends StatelessWidget {
  const RowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.lightGreen,
          radius: 100.0,
          child: Stack(
            children: <Widget>[
              Container(color: Colors.yellow, height: 100.0, width: 100.0),
              Container(color: Colors.amber, height: 100.0, width: 100.0),
              Container(color: Colors.brown, height: 40.0, width: 40.0),
            ],
          ),
        ),
      ],
    );
  }
}
