import 'package:e_commerence/services/payment_service.dart';
import 'package:e_commerence/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            child: Image.network(
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
                    onTap: () async {
                      double amount = double.tryParse(price) ?? 0;

                      // 1️⃣ Create Stripe Checkout Session
                      String? checkoutUrl =
                          await PaymentService.createCheckoutSession(
                            productName: name,
                            amount: amount,
                          );

                      if (checkoutUrl == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Payment failed")),
                        );
                        return;
                      }

                      // 2️⃣ Open Stripe Checkout in browser
                      await launchUrl(
                        Uri.parse(checkoutUrl),
                        mode: LaunchMode.externalApplication,
                      );
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

// import 'dart:convert';
// import 'package:e_commerence/services/payment_service.dart';
// import 'package:e_commerence/services/shared_pref.dart';
// import 'package:e_commerence/widget/support_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;

// class ProductDetail extends StatelessWidget {
//   final String image, name, price, detail;

//   const ProductDetail({
//     super.key,
//     required this.image,
//     required this.name,
//     required this.price,
//     required this.detail,
//   });

//   Future<void> saveOrder() async {
//     String? email = await SharedPreferenceHelper().getUserEmail();
//     String? userName = await SharedPreferenceHelper().getUserName();

//     final orderData = {
//       "userEmail": email,
//       "userName": userName,
//       "products": [
//         {"name": name, "price": double.parse(price), "quantity": 1},
//       ],
//       "totalAmount": double.parse(price),
//     };

//     await http.post(
//       Uri.parse("http://10.0.2.2:5000/api/orders"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(orderData),
//     );
//   }

//   Future<void> payNow(BuildContext context) async {
//     double amount = double.tryParse(price) ?? 0;

//     // 1️⃣ Create payment intent on backend
//     String? clientSecret = await PaymentService.createPaymentIntent(amount);

//     if (clientSecret == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Error creating payment intent")),
//       );
//       return;
//     }

//     // 2️⃣ Init payment sheet
//     await Stripe.instance.initPaymentSheet(
//       paymentSheetParameters: SetupPaymentSheetParameters(
//         paymentIntentClientSecret: clientSecret,
//         merchantDisplayName: "E-Commerce Store",
//       ),
//     );

//     // 3️⃣ Present payment sheet
//     try {
//       await Stripe.instance.presentPaymentSheet();

//       // 4️⃣ Save order in DB
//       await saveOrder();

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Payment successful! Order saved.")),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Payment failed: $e")));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFfef5f1),

//       // ⭐ APPBAR ADDED
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFfef5f1),
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             // Back Button in AppBar
//             GestureDetector(
//               onTap: () => Navigator.pop(context),
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 child: const Icon(Icons.arrow_back, color: Colors.black),
//               ),
//             ),
//             const SizedBox(width: 15),
//             Text("Product Details", style: AppStyles.heading),
//           ],
//         ),
//       ),

//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Product Image
//           Center(
//             child: Image.network(
//               image,
//               height: 350,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => const Icon(
//                 Icons.image_not_supported,
//                 size: 120,
//                 color: Colors.grey,
//               ),
//             ),
//           ),

//           // White Bottom Container
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//               ),

//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Title + Price
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           name,
//                           style: AppStyles.heading,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       Text("\$$price", style: AppStyles.heading),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   Text("Product Details", style: AppStyles.heading),
//                   const SizedBox(height: 5),
//                   Text(detail, style: AppStyles.subtitle),

//                   const Spacer(),

//                   // BUY NOW BUTTON
//                   GestureDetector(
//                     onTap: () async {
//                       await payNow(context);
//                     },

//                     child: Container(
//                       padding: const EdgeInsets.all(15),
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Text(
//                         "Buy Now",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
