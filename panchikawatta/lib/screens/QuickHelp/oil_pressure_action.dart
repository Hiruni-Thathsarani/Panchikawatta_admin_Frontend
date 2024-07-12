import 'package:flutter/material.dart';

class OilPressureAction extends StatelessWidget {
  const OilPressureAction({super.key});

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
          'Oil Pressure Warning',
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
                'assets/warning_lights/abs.jpg',
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'The oil pressure is low.\n\n'
              '1. Pull over immediately.\n'
              '2. Turn off engine.\n'
              '3. Check oil level and top up if needed.\n'
              '4. Seek professional help if light persists.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
