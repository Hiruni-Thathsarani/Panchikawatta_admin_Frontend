import 'package:flutter/material.dart';

class PowerSteeringAction extends StatelessWidget {
  const PowerSteeringAction({super.key});

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
          'Power Steering Warning',
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
                'assets/warning_lights/power_steering.jpg',
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'The power steering system is having an issue.\n\n'
              '1. If your vehicle has \bEPS (Electronic power system)\b, go to a mechanic to have the problem assessed.\n'
              '2. If it has the \bhydraulic power steering\b you need to topped off the power steering fluid.\n\n'
              'Schedule a maintenance appointment if issue persists.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
