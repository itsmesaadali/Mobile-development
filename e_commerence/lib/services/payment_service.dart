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

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class PaymentService {
//   static const String baseUrl =
//       "http://10.0.2.2:5000/api"; // For Android emulator

//   // Create Payment Intent
//   static Future<String?> createPaymentIntent(double amount) async {
//     try {
//       final res = await http.post(
//         Uri.parse("$baseUrl/stripe/create-payment-intent"),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"amount": amount}),
//       );

//       if (res.statusCode == 200) {
//         final data = jsonDecode(res.body);
//         return data["clientSecret"];
//       }
//       return null;
//     } catch (e) {
//       print("Payment Intent error: $e");
//       return null;
//     }
//   }
// }
