// lib/main.dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // const constructor supported

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MaximumBid(),
    );
  }
}

class MaximumBid extends StatefulWidget {
  const MaximumBid({Key? key}) : super(key: key);

  @override
  _MaximumBidState createState() => _MaximumBidState();
}

class _MaximumBidState extends State<MaximumBid> {
  int bid = 0;

  void increaseBid() {
    setState(() {
      bid += 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assignment 1, Task 1, Bidding Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // use Key so tests can find this text reliably
            Text(
              'Current Maximum Bid: \$${bid}',
              key: const Key('bidText'),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key('increaseButton'),
              onPressed: increaseBid,
              child: const Text('Increase Bid'),
            ),
          ],
        ),
      ),
    );
  }
}
