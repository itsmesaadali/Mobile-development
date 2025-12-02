import 'package:e_commerence/pages/bottomnav.dart';
import 'package:e_commerence/pages/login.dart';
import 'package:e_commerence/services/database.dart';
import 'package:e_commerence/services/shared_pref.dart';
import 'package:e_commerence/widget/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  registration() async {
    if (_formKey.currentState!.validate()) {
      String username = usernameController.text;
      String email = emailController.text;
      String password = passwordController.text;

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String id = randomAlphaNumeric(10);

        await SharedPreferenceHelper().saveUserEmail(email);
        await SharedPreferenceHelper().saveUserName(username);
        await SharedPreferenceHelper().saveUserId(id);
        await SharedPreferenceHelper().saveUserImage(
          "https://via.placeholder.com/150",
        );

        Map<String, dynamic> userInfoMap = {
          "Name": username,
          "Email": email,
          "id": id,
          "Image": "https://via.placeholder.com/150",
        };
        await DatabaseMethods().addUserDetails(userInfoMap, id);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNav()),
        );
      } on FirebaseAuthException catch (e) {
        String message = "";
        if (e.code == 'weak-password') {
          message = "The password provided is too weak.";
        } else if (e.code == 'email-already-in-use') {
          message = "The account already exists for that email.";
        } else {
          message = e.message ?? "Registration failed.";
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message, style: AppStyles.subtitle)),
        );
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
              Text("Sign Up", style: AppStyles.heading),
              const SizedBox(height: 10),
              Text(
                "Create a new account by entering your details below.",
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
                  hintText: "Username",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),

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

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: registration,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    "Sign Up",
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
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const Login()),
                      );
                    },
                    child: const Text(
                      "Login",
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
