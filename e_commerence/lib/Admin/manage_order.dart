import 'package:flutter/material.dart';

class ManageOrder extends StatefulWidget {
  const ManageOrder({super.key});

  @override
  State<ManageOrder> createState() => _ManageOrderState();
}

class _ManageOrderState extends State<ManageOrder> {
  // ------- STATIC ORDERS DATA ------- //
  List<Map<String, dynamic>> orders = [
    {
      "productName": "Wireless Headphones",
      "price": "59.99",
      "image": "images/headphones.webp",
      "buyer": "Haroon Abbas",
      "email": "haroon@example.com",
      "date": "2025-01-10",
      "status": "Pending",
    },
    {
      "productName": "Smart TV 43 inch",
      "price": "399.99",
      "image": "images/tv.webp",
      "buyer": "Ali Raza",
      "email": "ali@example.com",
      "date": "2025-01-08",
      "status": "Pending",
    },
    {
      "productName": "Gaming Laptop",
      "price": "999.99",
      "image": "images/laptop.webp",
      "buyer": "Hina Khan",
      "email": "hina@example.com",
      "date": "2025-01-05",
      "status": "Confirmed",
    },
  ];

  void updateStatus(int index, String newStatus) {
    setState(() {
      orders[index]["status"] = newStatus;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Order ${newStatus.toLowerCase()} (static)")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Manage Orders",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            var order = orders[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ------- PRODUCT + IMAGE ------- //
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          order["image"],
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order["productName"],
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\$${order["price"]}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // ------- BUYER INFO ------- //
                  Text(
                    "Buyer: ${order["buyer"]}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "Email: ${order["email"]}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "Date: ${order["date"]}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  const SizedBox(height: 15),

                  // ------- ORDER STATUS ------- //
                  Row(
                    children: [
                      const Text(
                        "Status:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: order["status"] == "Confirmed"
                              ? Colors.green.shade100
                              : order["status"] == "Rejected"
                              ? Colors.red.shade100
                              : Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          order["status"],
                          style: TextStyle(
                            color: order["status"] == "Confirmed"
                                ? Colors.green
                                : order["status"] == "Rejected"
                                ? Colors.red
                                : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // ------- ACTION BUTTONS ------- //
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => updateStatus(index, "Confirmed"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Confirm",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => updateStatus(index, "Rejected"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Reject",
                            style: TextStyle(color: Colors.white),
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
