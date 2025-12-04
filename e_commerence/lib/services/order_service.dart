import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderService {
  static const String baseUrl = "http://localhost:5000/api/orders";

  // Get all orders (Admin)
  static Future<List<dynamic>> getAllOrders() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return [];
    } catch (e) {
      print("Order fetch error: $e");
      return [];
    }
  }

  // Update order status
  static Future<bool> updateOrderStatus(
    String orderId,
    String newStatus,
  ) async {
    try {
      final response = await http.patch(
        Uri.parse("$baseUrl/$orderId/status"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"status": newStatus}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Order update error: $e");
      return false;
    }
  }
}
