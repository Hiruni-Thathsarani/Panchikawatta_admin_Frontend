import 'package:flutter/material.dart';

// ignore: camel_case_types
class notification_page extends StatelessWidget {
  const notification_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xFFFF5C01),
            fontSize: 27,
            fontWeight: FontWeight.w500,
            
          ),
        ),
      ),
      body: const Center(
        child: Text('Notification Page Content'),
      ),
    );
  }
}
