import 'package:e_commerence/widget/support_widget.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final String image, name, price, detail;

  const ProductDetail({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfef5f1),

      // ⭐ APPBAR ADDED
      appBar: AppBar(
        backgroundColor: const Color(0xFFfef5f1),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            // Back Button in AppBar
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black),
                ),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
            const SizedBox(width: 15),
            Text("Product Details", style: AppStyles.heading),
          ],
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Center(
            child: Image.asset(
              image,
              height: 350,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.image_not_supported,
                size: 120,
                color: Colors.grey,
              ),
            ),
          ),

          // White Bottom Container
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: AppStyles.heading,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text("\$$price", style: AppStyles.heading),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Text("Product Details", style: AppStyles.heading),
                  const SizedBox(height: 5),
                  Text(detail, style: AppStyles.subtitle),

                  const Spacer(),

                  // BUY NOW BUTTON
                  GestureDetector(
                    onTap: () {
                      // later backend checkout API
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Buy Now",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
