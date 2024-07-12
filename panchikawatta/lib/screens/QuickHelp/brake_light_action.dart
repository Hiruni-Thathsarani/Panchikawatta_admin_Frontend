import 'package:flutter/material.dart';

class BrakeLightAction extends StatelessWidget {
  const BrakeLightAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Brake Warning',
          style: TextStyle(
            color: Color(0xFFFF5C01),
            fontSize: 27,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/warning_lights/brake.jpg',
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Check the parking brake is still engaged.\n\n'
              '1. If the light persists after releasing brake, there can be a issue in brake system.\n'
              '2. Have the vehicle towed for repairs, it is not safe to drive.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
