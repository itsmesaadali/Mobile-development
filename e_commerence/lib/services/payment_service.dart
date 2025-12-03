import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  static const String baseUrl = "http://localhost:5000/api/stripe";

  static Future<String?> createCheckoutSession({
    required String productName,
    required double amount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/create-checkout-session"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"productName": productName, "amount": amount}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["url"]; // Stripe Checkout URL
      }
    } catch (e) {
      print("Checkout error: $e");
    }
    return null;
  }
}
