import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = "http://localhost:3000";

  static Future createActivity({
    required String image,
    required String location,
  }) async {
    await http.post(
      Uri.parse("$baseUrl/activity"),
      body: jsonEncode({
        "image": image,
        "location": location,
        "timestamp": DateTime.now().toString(),
      }),
      headers: {"Content-Type": "application/json"},
    );
  }

  static Future<List> getActivities() async {
    final res = await http.get(Uri.parse("$baseUrl/activity"));
    return jsonDecode(res.body);
  }

  static Future deleteActivity(String id) async {
    await http.delete(Uri.parse("$baseUrl/activity/$id"));
  }
}
