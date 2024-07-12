import 'package:flutter/material.dart';
import 'package:panchikawatta/components/custom_button.dart';
import 'package:panchikawatta/screens/auth_functions.dart';

class DeleteProfileDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        //color: Colors.white,
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,   //left, 
            20,  // top, 
            20,  // right, 
            20,  // bottom
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Are you sure you want to delete your profile?', style: TextStyle(fontSize: 18, color: Colors.black),),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.30,  // Specify your desired width
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your button press logic here
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(MediaQuery.of(context).size.width * 0.38, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          // side: const BorderSide(color: Color(0xFFFF5C01)),
                        ),
                      ),
                      child: const Text('No', style: TextStyle(fontSize: 16, color: Color(0xFFFF5C01))),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.30,  // Specify your desired width
                    child: CustomButton(
                      onPressed: () {
                        // Add your button press logic here
                      }, 
                      text: 'Yes'
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        //color: Colors.white,
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,   //left, 
            20,  // top, 
            20,  // right, 
            20,  // bottom
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Are you sure you want to logout?', style: TextStyle(fontSize: 18, color: Colors.black),),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.30,  // Specify your desired width
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your button press logic here
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(MediaQuery.of(context).size.width * 0.38, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          // side: const BorderSide(color: Color(0xFFFF5C01)),
                        ),
                      ),
                      child: const Text('No', style: TextStyle(fontSize: 16, color: Color(0xFFFF5C01))),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.30,  // Specify your desired width
                    child: CustomButton(
                      onPressed: () => logout(context), //logout happens
                      text: 'Yes'
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}