import 'package:e_commerence/pages/bottomnav.dart';
import 'package:e_commerence/pages/signup.dart';
import 'package:e_commerence/services/database.dart';
import 'package:e_commerence/services/shared_pref.dart';
import 'package:e_commerence/widget/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  userLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userData = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );

        String uid = userData.user!.uid;

        // 🔥 Fetch Firestore user data
        var userSnapshot = await DatabaseMethods().getUserDetails(uid);

        if (!userSnapshot.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User record missing in Firestore")),
          );
          return;
        }

        var user = userSnapshot.data()!;

        // 🔥 Save locally
        await SharedPreferenceHelper().saveUserId(uid);
        await SharedPreferenceHelper().saveUserName(user["Name"]);
        await SharedPreferenceHelper().saveUserEmail(user["Email"]);
        await SharedPreferenceHelper().saveUserImage(user["Image"]);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BottomNav()),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
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
              Image.asset(
                "images/start.webp",
                height: 200,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Text("Sign In", style: AppStyles.heading),
              const SizedBox(height: 10),
              Text(
                "Welcome back! Please enter your credentials to continue.",
                style: AppStyles.subtitle,
              ),
              const SizedBox(height: 30),

              // Email
              Text("Email", style: AppStyles.label),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                validator: (value) =>
                    value!.isEmpty ? "Email cannot be empty" : null,
                decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),

              // Password
              Text("Password", style: AppStyles.label),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                validator: (value) =>
                    value!.isEmpty ? "Password cannot be empty" : null,
                obscureText: true,
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
                  onPressed: userLogin,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const Signup()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
