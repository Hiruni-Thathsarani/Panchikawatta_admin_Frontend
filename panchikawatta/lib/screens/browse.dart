import 'package:panchikawatta/main.dart';
import 'package:panchikawatta/screens/login.dart';
import 'package:flutter/material.dart';

class browse extends StatelessWidget {
  const browse({Key? key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            ),
            const SizedBox(height: 40),
            Image.asset(
              'lib/src/img/orange logo 1.png',
              height: 150,
              width: 200,
            ),
            const SizedBox(height: 90),
            Container(
              width: size.width * 0.3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => login()),
                    );
                  },
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      const Color(0xFFFF5C01),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "or",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Container(
              width: size.width * 1.8,
              child: const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: size.width * 0.3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage()),
                    );
                  },
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      const Color(0xFFFF5C01),
                    ),
                  ),
                  child: const Text(
                    "Browse",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
