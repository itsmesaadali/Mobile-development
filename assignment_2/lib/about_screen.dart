import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  final List<Map<String, String>> attractions = const [
    {'img': 'https://picsum.photos/200?1', 'name': 'Eiffel Tower'},
    {'img': 'https://picsum.photos/200?2', 'name': 'Great Wall'},
    {'img': 'https://picsum.photos/200?3', 'name': 'Taj Mahal'},
    {'img': 'https://picsum.photos/200?4', 'name': 'Sydney Opera House'},
    {'img': 'https://picsum.photos/200?5', 'name': 'Pyramids of Giza'},
    {'img': 'https://picsum.photos/200?6', 'name': 'Statue of Liberty'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.9,
        ),
        itemCount: attractions.length,
        itemBuilder: (context, index) {
          final item = attractions[index];
          return Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(item['img']!, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                item['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
