import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  final List<Map<String, String>> destinations = const [
    {'name': 'Paris', 'desc': 'The city of lights and love.'},
    {'name': 'Tokyo', 'desc': 'Blend of tradition and technology.'},
    {'name': 'New York', 'desc': 'The city that never sleeps.'},
    {'name': 'London', 'desc': 'Home of the Big Ben.'},
    {'name': 'Dubai', 'desc': 'Land of luxury and skyscrapers.'},
    {'name': 'Rome', 'desc': 'Ancient history and art.'},
    {'name': 'Istanbul', 'desc': 'Where East meets West.'},
    {'name': 'Bangkok', 'desc': 'Vibrant street life and temples.'},
    {'name': 'Bali', 'desc': 'Island paradise in Indonesia.'},
    {'name': 'Sydney', 'desc': 'Home of the Opera House.'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: destinations.length,
      itemBuilder: (context, index) {
        final place = destinations[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: const Icon(Icons.location_on, color: Colors.teal),
            title: Text(place['name']!),
            subtitle: Text(place['desc']!),
          ),
        );
      },
    );
  }
}
