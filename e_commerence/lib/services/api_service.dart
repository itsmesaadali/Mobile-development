import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ApiService {
  static const String baseUrl = "http://localhost:5000/api";

  // ---------------------------------------------------
  // 🔵 ADD PRODUCT (POST)
  // ---------------------------------------------------
  static Future<bool> addProduct({
    required String name,
    required String price,
    required String detail,
    required String category,
    required XFile image, // Web-safe image
  }) async {
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("$baseUrl/products"),
      );

      // Normal fields
      request.fields["name"] = name;
      request.fields["price"] = price;
      request.fields["detail"] = detail;
      request.fields["category"] = category;

      // Read image bytes for web
      Uint8List fileBytes = await image.readAsBytes();

      request.files.add(
        http.MultipartFile.fromBytes('image', fileBytes, filename: image.name),
      );

      var response = await request.send();

      return response.statusCode == 201;
    } catch (e) {
      print("Add product error: $e");
      return false;
    }
  }

  // ---------------------------------------------------
  // 🟢 GET ALL PRODUCTS (GET)
  // ---------------------------------------------------
  static Future<List<dynamic>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/products"));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      print("Error loading products: $e");
      return [];
    }
  }

  // GET PRODUCTS BY CATEGORY
  static Future<List<dynamic>> getProductsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/products/category/$category"),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return [];
    } catch (e) {
      print("Category fetch error: $e");
      return [];
    }
  }

  // ---------------------------------------------------
  // 🔴 DELETE PRODUCT (DELETE)
  // ---------------------------------------------------
  static Future<bool> deleteProduct(String id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/products/$id"));

      return response.statusCode == 200;
    } catch (e) {
      print("Delete error: $e");
      return false;
    }
  }

  // ---------------------------------------------------
  // 🟡 UPDATE PRODUCT (PUT)
  // ---------------------------------------------------
  static Future<bool> updateProduct({
    required String id,
    required String name,
    required String price,
    required String detail,
    required String category,
    XFile? image, // Optional (if user picks new image)
  }) async {
    try {
      var request = http.MultipartRequest(
        "PUT",
        Uri.parse("$baseUrl/products/$id"),
      );

      request.fields["name"] = name;
      request.fields["price"] = price;
      request.fields["detail"] = detail;
      request.fields["category"] = category;

      if (image != null) {
        Uint8List fileBytes = await image.readAsBytes();
        request.files.add(
          http.MultipartFile.fromBytes(
            "image",
            fileBytes,
            filename: image.name,
          ),
        );
      }

      var response = await request.send();
      return response.statusCode == 200;
    } catch (e) {
      print("Update error: $e");
      return false;
    }
  }
}
