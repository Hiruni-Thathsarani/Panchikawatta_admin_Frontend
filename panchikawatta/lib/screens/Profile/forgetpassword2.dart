import 'package:panchikawatta/screens/Profile/forgetpassword3.dart';
import 'package:panchikawatta/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

class forget_password2 extends StatefulWidget {
  const forget_password2({Key? key}) : super(key: key);

  @override
  _reset1State createState() => _reset1State();
}

class _reset1State extends State<forget_password2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 55),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 55),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      "Verification",
                      style: TextStyle(
                        color: Color(0xFFFF5C01),
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Text(
                  "Enter Verification Code",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 68,
                    width: 60,
                    child: TextField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      decoration: const InputDecoration(hintText: "0"),
                      style: Theme.of(context).textTheme.titleLarge,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 60,
                    child: TextField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      decoration: const InputDecoration(hintText: "0"),
                      style: Theme.of(context).textTheme.titleLarge,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 60,
                    child: TextField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      decoration: const InputDecoration(hintText: "0"),
                      style: Theme.of(context).textTheme.titleLarge,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 60,
                    child: TextField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      decoration: const InputDecoration(hintText: "0"),
                      style: Theme.of(context).textTheme.titleLarge,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      "If you didn’t receive a code",
                      style: TextStyle(
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: const Text(
                        "Resend",
                        style: TextStyle(
                          color: Color(0xFFFF8000),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onEnter: (PointerEnterEvent event) {
                        // Change color when hovering
                        // Update the text style
                        // You can directly set the color here
                        // Or you can define a new TextStyle object with the desired color
                      },
                      onExit: (PointerExitEvent event) {
                        // Restore original TextStyle when not hovering
                      },
                    ),
                  ),
                ],
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
                        MaterialPageRoute(
                            builder: (context) => const forget_password3()),
                      );
                    },
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      ),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color(0xFFFF5C01),
                      ),
                    ),
                    child: const Text(
                      "send",
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
