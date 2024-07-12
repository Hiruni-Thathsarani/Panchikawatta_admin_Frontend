import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panchikawatta/screens/SignUp/sign_up2.dart';

class Registraion_success extends StatefulWidget {
  final int userId;

  Registraion_success({Key? key, required this.userId}) : super(key: key);

  @override
  State<Registraion_success> createState() => _Registraion_successState();
}

class _Registraion_successState extends State<Registraion_success>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 5), () {
      final userId = widget.userId;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => sign_up2(userId: userId),
        ),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 247, 247, 247),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                'lib/src/img/Success.png',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Registration successful',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 227, 111, 8),
                fontSize: 34,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
