import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // ADD USER (Signup)
  Future addUserDetails(Map<String, dynamic> userInfoMap, String uid) async {
    return await FirebaseFirestore.instance
        .collection("users") // << SAME EVERYWHERE
        .doc(uid)
        .set(userInfoMap);
  }

  // GET USER (Login)
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails(
    String uid,
  ) async {
    return await FirebaseFirestore.instance
        .collection("users") // << SAME COLLECTION
        .doc(uid)
        .get();
  }
}
