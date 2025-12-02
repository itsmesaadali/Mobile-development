import 'package:e_commerence/widget/support_widget.dart';
import 'package:flutter/material.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    // Temporary static order list
    final List<Map<String, dynamic>> orders = [
      {
        "name": "Wireless Headphones",
        "price": "59.99",
        "image": "images/headphones.webp",
        "date": "12 Jan 2025 • 4:30 PM",
      },
      {
        "name": "Gaming Laptop",
        "price": "999.99",
        "image": "images/laptop.webp",
        "date": "10 Jan 2025 • 1:15 PM",
      },
      {
        "name": "Smart TV",
        "price": "499.99",
        "image": "images/tv.webp",
        "date": "08 Jan 2025 • 9:45 AM",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: const Color(0xfff2f2f2),
        elevation: 0,
        centerTitle: true,
        title: Text("Current Orders", style: AppStyles.heading),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      order["image"],
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.image_not_supported,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order["name"],
                          style: AppStyles.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),

                        Text("\$${order["price"]}", style: AppStyles.heading),
                        const SizedBox(height: 8),

                        Text(
                          "Status: Processing",
                          style: AppStyles.subtitle.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),

                        Text(
                          "Ordered on: ${order["date"]}",
                          style: AppStyles.subtitle.copyWith(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
