import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ApiService {
  static const String baseUrl = "http://localhost:5000/api/products";

  static Future<bool> addProduct({
    required String name,
    required String price,
    required String detail,
    required String category,
    required XFile image, // <-- XFILE for web
  }) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(baseUrl));

      // Normal text fields
      request.fields["name"] = name;
      request.fields["price"] = price;
      request.fields["detail"] = detail;
      request.fields["category"] = category;

      // Web-safe uploading using bytes
      Uint8List fileBytes = await image.readAsBytes();

      request.files.add(
        http.MultipartFile.fromBytes('image', fileBytes, filename: image.name),
      );

      var response = await request.send();

      if (response.statusCode == 201) return true;
      return false;
    } catch (e) {
      print("Add product error: $e");
      return false;
    }
  }
}
