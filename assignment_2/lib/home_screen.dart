import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 🔹 Travel image
          Image.asset('assets/travel.jpg', fit: BoxFit.cover),

          // 🔹 Welcome message inside container
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.lightBlue.shade50,
            child: const Text(
              'Welcome to the Travel Guide App! Discover your next adventure and explore the world!',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 10),

          // 🔹 RichText slogan
          RichText(
            text: const TextSpan(
              text: 'Explore the ',
              style: TextStyle(fontSize: 20, color: Colors.black),
              children: [
                TextSpan(
                  text: 'World',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' with '),
                TextSpan(
                  text: 'Us!',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 🔹 TextField for destination input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Enter Destination',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 🔹 Buttons section
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ElevatedButton clicked!')),
              );
            },
            child: const Text('Explore Now'),
          ),

          TextButton(
            onPressed: () {
              print('TextButton pressed!');
            },
            child: const Text('Learn More'),
          ),
        ],
      ),
    );
  }
}
