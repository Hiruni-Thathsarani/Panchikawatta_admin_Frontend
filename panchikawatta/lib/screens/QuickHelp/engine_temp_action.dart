import 'package:flutter/material.dart';

class EngineTempAction extends StatelessWidget {
  const EngineTempAction({super.key});

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
          'Engine Temperature Warning',
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
                'assets/warning_lights/engine_temp.jpg',
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'The engine is overheated\n\n'
              '1. Pull over safely\n'
              '2. Turn off engine and allow to cool.\n'
              '3. Check coolant levels when safe.\n'
              '4. Seek professional help if issue persists.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
