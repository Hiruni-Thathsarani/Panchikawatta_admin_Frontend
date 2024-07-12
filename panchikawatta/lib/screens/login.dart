import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:panchikawatta/global/common/toast.dart';
import 'package:panchikawatta/main.dart';
import 'package:panchikawatta/screens/Profile/forgetpassword1.dart';
import 'package:panchikawatta/screens/SignUp/sign_up1.dart';
import 'package:panchikawatta/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<login> {
  bool _isSigning = false;
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // TextEditingController _email = TextEditingController();    //shashini
  // TextEditingController _password = TextEditingController();
  // bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xFFFF5C01),
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Image.asset(
                  'lib/src/img/orange logo 1.png',
                  height: 150,
                  width: 200,
                ),
              ),
              const SizedBox(height: 2),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Text(
                  "Welcome to Panchikawatta",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15, // Adjust the font size here
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFieldContainer(
                child: TextField(
                  controller: emailController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextFieldContainer(
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgetPassword1()),
                      );
                    },
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(29),
                ),
                child: ElevatedButton(
                  onPressed: _signIn,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    backgroundColor: const Color(0xFFFF5C01),
                  ),
                  child: _isSigning
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      "Don't have an Account?",
                      style: TextStyle(
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => sign_up1()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFFFF8000),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      if (user.emailVerified) {
        showToast(message: "You are successfully signed in");

        // Generate JWT token
        String? jwtToken = await _generateJwtToken(user);

        if (jwtToken != null) {
          // Save JWT token locally if needed
          // Example: saveTokenLocally(jwtToken);

          // Navigate to home page after successful login
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ),
          );
        } else {
          showToast(message: "Failed to generate JWT token");
        }
      } else {
        showToast(message: "Please verify your email before login");
      }
    } else {
      showToast(message: "Invalid email or password");
    }
  }

  Future<String?> _generateJwtToken(User user) async {
    try {
      // Get the Firebase ID token
      String? idToken = await user.getIdToken();
      print('Received idToken token: $idToken');

      // Call your Node.js server to generate JWT token
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/users/generateJwtToken'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'idToken': idToken}),
      );

      if (response.statusCode == 201) {
        // Assuming your server returns the JWT token in the response body
        final responseData = jsonDecode(response.body);
        return responseData['token'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error generating JWT token: $e');
      return null;
    }
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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

void main() {
  runApp(MaterialApp(
    home: login(),
  ));
}
