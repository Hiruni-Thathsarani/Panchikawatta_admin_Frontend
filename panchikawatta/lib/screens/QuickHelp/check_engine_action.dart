import 'package:flutter/material.dart';

class CheckEngineAction extends StatelessWidget {
  const CheckEngineAction({super.key});

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
          'Check Engine Warning',
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
                'assets/warning_lights/check_engine.jpg',
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Potential to have an issue with the engine\n\n'
              '1. Pull over safely\n'
              '2. Check the fuel cap is tightened securely.\n'
              '3. Inspect any loosen connections in any visible hoses, wires, and connections under the hood.\n'
              '4. If any abnormal sound, performance issue immediately ask for professional help.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
