import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Widget Tree')),
        body: SafeAreaWidget(),
      ),
    );
  }
}

class SafeAreaWidget extends StatelessWidget {
  const SafeAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SignleChildScrollViewWidget());
  }
}

class SignleChildScrollViewWidget extends StatelessWidget {
  const SignleChildScrollViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: PaddingWdiget());
  }
}

class PaddingWdiget extends StatelessWidget {
  const PaddingWdiget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInstetsWidget(),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(color: Colors.yellow, height: 40.0, width: 40.0),
              Padding(padding: EdgeInstetsWidget()),
              ExpandedWidget(),
              Padding(padding: EdgeInstetsWidget()),
              Container(color: Colors.brown, height: 40.0, width: 40.0),
            ],
          ),
          Padding(padding: EdgeInstetsWidget()),
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
                  Divider(),
                  RowWidget(),
                  Divider(),
                  Text('End of the Line'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  EdgeInsets EdgeInstetsWidget() => EdgeInsets.all(16.0);
}

class ExpandedWidget extends StatelessWidget {
  const ExpandedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(color: Colors.amber, height: 40.0, width: 40.0),
    );
  }
}

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
