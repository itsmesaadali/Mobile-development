import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerence/Admin/home_admin.dart';
import 'package:e_commerence/widget/support_widget.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  loginAdmin() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
        bool found = false;

        for (var result in snapshot.docs) {
          if (result.data()["username"] == usernameController.text.trim() &&
              result.data()["password"] == passwordController.text.trim()) {
            found = true;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeAdmin()),
            );
            break;
          }
        }

        if (!found) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Invalid username or password",
                style: AppStyles.subtitle,
              ),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Image
              Image.asset(
                "images/start.webp",
                height: 200,
                width: double.infinity,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 20),

              Text("Admin Login", style: AppStyles.heading),

              const SizedBox(height: 10),
              Text(
                "Enter your admin credentials to continue.",
                style: AppStyles.subtitle,
              ),

              const SizedBox(height: 30),

              // Username
              Text("Username", style: AppStyles.label),
              const SizedBox(height: 10),
              TextFormField(
                controller: usernameController,
                validator: (value) =>
                    value!.isEmpty ? "Username cannot be empty" : null,
                decoration: const InputDecoration(
                  hintText: "Admin username",
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 20),

              // Password
              Text("Password", style: AppStyles.label),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? "Password cannot be empty" : null,
                decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                ),
              ),

              const SizedBox(height: 30),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loginAdmin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
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
    );
  }
}
