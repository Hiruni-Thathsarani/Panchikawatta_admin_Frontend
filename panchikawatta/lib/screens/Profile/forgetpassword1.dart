import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panchikawatta/screens/login.dart';

class ForgetPassword1 extends StatefulWidget {
  const ForgetPassword1({Key? key}) : super(key: key);

  @override
  _ForgetPassword1State createState() => _ForgetPassword1State();
}

class _ForgetPassword1State extends State<ForgetPassword1> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    try {
      String email = _emailController.text.trim();

      if (email.isEmpty) {
        throw FirebaseAuthException(
          code: 'invalid-email',
          message: 'Please enter an email address.',
        );
      }

      // Send password reset email using Firebase Authentication
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Password reset link sent! Check your email.'),
          );
        },
      );
      await Future.delayed(const Duration(seconds: 4));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => login()),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      String errorMessage = 'An error occurred';

      if (e.code == 'invalid-email') {
        errorMessage = 'Please enter valid email address.';
      } else {
        errorMessage = e.message ?? 'Unknown error occurred.';
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(errorMessage),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Forgot Password",
                style: TextStyle(
                  color: Color(0xFFFF5C01),
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Text(
                  "Enter Email Address",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextField(
                  controller: _emailController,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    filled: true,
                    fillColor: const Color.fromRGBO(238, 237, 236, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: TextButton(
                    onPressed: _resetPassword,
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      ),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color(0xFFFF5C01),
                      ),
                    ),
                    child: const Text(
                      "Send",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Text(
                  "Do you have an Account?",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => login()),
                      );
                    },
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      ),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(255, 244, 242, 242),
                      ),
                    ),
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                          color: Color.fromARGB(255, 59, 53, 53)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(246, 243, 243, 0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
