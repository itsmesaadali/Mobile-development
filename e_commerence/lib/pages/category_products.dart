import 'package:e_commerence/pages/product_detail.dart';
import 'package:e_commerence/widget/support_widget.dart';
import 'package:flutter/material.dart';

class CategoryProduct extends StatelessWidget {
  final String category;
  CategoryProduct({super.key, required this.category});

  // STATIC TEMPORARY DATA
  final Map<String, List<Map<String, dynamic>>> staticProducts = {
    "TV": [
      {
        "name": "Smart LED TV 43 inch",
        "price": "399.99",
        "image": "images/tv.webp",
        "detail": "High quality smart LED TV with HD display.",
      },
      {
        "name": "Ultra HD TV 55 inch",
        "price": "699.99",
        "image": "images/tv.webp",
        "detail": "4K UHD display with HDR support.",
      },
    ],
    "Laptop": [
      {
        "name": "Gaming Laptop",
        "price": "999.99",
        "image": "images/laptop.webp",
        "detail": "High-performance gaming laptop with RGB keyboard.",
      },
      {
        "name": "Office Laptop",
        "price": "599.99",
        "image": "images/laptop.webp",
        "detail": "Perfect for work, study and productivity.",
      },
    ],
    "Headphones": [
      {
        "name": "Wireless Headphones",
        "price": "59.99",
        "image": "images/headphones.webp",
        "detail": "Noise cancellation and long battery life.",
      },
      {
        "name": "Studio Headphones",
        "price": "89.99",
        "image": "images/headphones.webp",
        "detail": "Premium sound and deep bass output.",
      },
    ],
    "Stopwatch": [
      {
        "name": "Digital Stopwatch",
        "price": "19.99",
        "image": "images/stopwatch.webp",
        "detail": "Precise stopwatch for sports and running.",
      },
    ],
    "Digital Watch": [
      {
        "name": "Smart Digital Watch",
        "price": "49.99",
        "image": "images/digitalwatch.webp",
        "detail": "Tracks fitness and steps with notifications.",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products = staticProducts[category] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: const Color(0xfff2f2f2),
        elevation: 0,
        title: Text(category, style: AppStyles.heading),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.62,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            var product = products[index];

            return Container(
              padding: const EdgeInsets.all(10),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetail(
                              image: product["image"],
                              name: product["name"],
                              price: product["price"],
                              detail: product["detail"],
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          product["image"],
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.image_not_supported,
                            size: 80,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Product Name
                  Text(
                    product["name"],
                    style: AppStyles.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const Spacer(),

                  // Price + Cart Button
                  Row(
                    children: [
                      Text("\$${product["price"]}", style: AppStyles.heading),
                      const Spacer(),

                      // UPDATED CART CLICK → GO TO PRODUCT DETAIL
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetail(
                                image: product["image"],
                                name: product["name"],
                                price: product["price"],
                                detail: product["detail"],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart,
                            color: Color(0xFFfd6f3e),
                          ),
                        ),
                      ),
                    ],
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
