// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:panchikawatta/components/custom_button.dart';
import 'package:panchikawatta/screens/profile_page.dart';

class PostUnsuccess extends StatelessWidget {
  // ignore: use_super_parameters
  const PostUnsuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cancel_rounded, size: 100, color: Color(0xFFFF5C01)),
              Text(
                'Ad Posted Unsuccessful!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFFFF5C01),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Try Again',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
