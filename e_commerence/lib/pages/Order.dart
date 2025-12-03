import 'dart:convert';
import 'package:e_commerence/services/shared_pref.dart';
import 'package:e_commerence/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<Order> {
  bool loading = true;
  List<dynamic> orders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    String? email = await SharedPreferenceHelper().getUserEmail();

    if (email == null) {
      setState(() => loading = false);
      return;
    }

    try {
      final res = await http.get(
        Uri.parse("http://localhost:5000/api/orders/my/$email"),
      );

      if (res.statusCode == 200) {
        orders = jsonDecode(res.body);
      }
    } catch (e) {
      print("Order fetch error: $e");
    }

    setState(() => loading = false);
  }

  Color statusColor(String status) {
    switch (status) {
      case "Confirmed":
        return Colors.green;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        title: Text("My Order", style: AppStyles.heading),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
          ? const Center(
              child: Text("No orders yet", style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var order = orders[index];
                var productList = order["products"] as List;

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(15),
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
                      // Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order Status:", style: AppStyles.subtitle),
                          Text(
                            order["status"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: statusColor(order["status"]),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Product List
                      ...productList.map((item) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item["name"], style: AppStyles.heading),
                            Text(
                              "Price: \$${item["price"]}",
                              style: AppStyles.subtitle,
                            ),
                            Text(
                              "Quantity: ${item["quantity"]}",
                              style: AppStyles.subtitle,
                            ),
                            const Divider(),
                          ],
                        );
                      }).toList(),

                      // Total
                      Text(
                        "Total Amount: \$${order["totalAmount"]}",
                        style: AppStyles.heading,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Placed on: ${order["createdAt"].toString().substring(0, 10)}",
                        style: AppStyles.subtitle,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
