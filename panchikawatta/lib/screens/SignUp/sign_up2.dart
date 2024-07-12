import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:panchikawatta/components/custom_button.dart';
import 'package:panchikawatta/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:panchikawatta/screens/SignUp/Vehicledetails1.dart';

class sign_up2 extends StatefulWidget {
  final int userId;
  sign_up2({required this.userId});
  @override
  State<StatefulWidget> createState() {
    return _SignUp2State();
  }
}

class PhoneNumberValidationResult {
  final bool isValid;
  final String message;

  PhoneNumberValidationResult(this.isValid, this.message);
}

class _SignUp2State extends State<sign_up2> {
  String? imagePath;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessAddressController =
      TextEditingController();
  final TextEditingController businessPhoneNoController =
      TextEditingController();
  final TextEditingController businessDescriptionController =
      TextEditingController();
  PhoneNumberValidationResult? phoneValidationResult;
  bool isFormFilled = false;
  @override
  void initState() {
    super.initState();

    businessNameController.addListener(_updateFormFilledStatus);
    businessAddressController.addListener(_updateFormFilledStatus);
    businessPhoneNoController.addListener(_updateFormFilledStatus);
    businessDescriptionController.addListener(_updateFormFilledStatus);
  }

  @override
  void dispose() {
    businessNameController.removeListener(_updateFormFilledStatus);
    businessAddressController.removeListener(_updateFormFilledStatus);
    businessPhoneNoController.removeListener(_updateFormFilledStatus);
    businessDescriptionController.removeListener(_updateFormFilledStatus);

    businessNameController.dispose();
    businessAddressController.dispose();
    businessPhoneNoController.dispose();
    businessDescriptionController.dispose();
    super.dispose();
  }

  void _updateFormFilledStatus() {
    setState(() {
      isFormFilled = businessNameController.text.trim().isNotEmpty ||
          businessAddressController.text.trim().isNotEmpty ||
          businessPhoneNoController.text.trim().isNotEmpty ||
          businessDescriptionController.text.trim().isNotEmpty;
    });
  }

  PhoneNumberValidationResult validatePhoneNumber(String value) {
    // Phone number must be exactly 10 digits
    if (RegExp(r'[A-Za-z]').hasMatch(value)) {
      return PhoneNumberValidationResult(
          false, 'Phone number must not contain letters');
    }
    if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return PhoneNumberValidationResult(
          false, 'Phone number must be exactly 10 digits');
    }
    return PhoneNumberValidationResult(true, 'Phone number is valid');
  }

  void _showFillMessage(String message, [String? emailError]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Fill Required Field"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message),
              if (emailError != null) Text(emailError),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, String?>? data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String?>?;

    // String fname = data?['firstname'] ?? '';
    // String lname = data?['lastname'] ?? '';
    // String username = data?['username'] ?? '';
    // String password = data?['password'] ?? '';
    // String email = data?['email'] ?? '';
    // String phoneno = data?['phoneno'] ?? '';
    // String? district = data?['district'];
    // String? province = data?['province'];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //   },
                    //   child: Icon(Icons.arrow_back),
                    // ),
                    SizedBox(width: 10),
                    Text(
                      "Fill your Profile",
                      style: TextStyle(
                        color: Color(0xFFFF5C01),
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Text(
                  "If you want to sell, fill this out",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              TextFieldContainer(
                child: TextField(
                  controller: businessNameController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: "Business Name",
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextFieldContainer(
                child: TextField(
                  controller: businessAddressController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: "Business Address",
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextFieldContainer(
                child: TextFormField(
                  controller: businessPhoneNoController,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      // Custom phone number validation
                      PhoneNumberValidationResult validationResult =
                          validatePhoneNumber(value);
                      if (!validationResult.isValid) {
                        // Display error message for invalid phone number
                        return validationResult.message;
                      }
                    }
                    return null; // Return null if no validation error
                  },
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "Phone (+94)",
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextFieldContainer(
                child: TextField(
                  cursorColor: Colors.black,
                  controller: businessDescriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: "Business description",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: CustomButton(
                        onPressed: () {
                          final userId = widget.userId;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Vehicledetails1(userId: userId)),
                          );
                        },
                        text: 'Skip',
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: TextButton(
                        onPressed: isFormFilled
                            ? () async {
                                onPressed:
                                isFormFilled
                                    ? () async {
                                        if (businessPhoneNoController.text
                                            .trim()
                                            .isEmpty) {
                                          _showFillMessage(
                                              'Please enter a phone number');
                                          return;
                                        }

                                        PhoneNumberValidationResult
                                            validationResult =
                                            validatePhoneNumber(
                                                businessPhoneNoController.text
                                                    .trim());

                                        if (!validationResult.isValid) {
                                          _showFillMessage(
                                              validationResult.message);
                                          return;
                                        }
                                      }
                                    : null;

                                Map<String, dynamic> userData = {
                                  'userId': widget.userId,

                                  'businessName':
                                      businessNameController.text.trim(),
                                  'businessAddress':
                                      businessAddressController.text.trim(),
                                  'businessPhoneNo':
                                      businessPhoneNoController.text.trim(),
                                  'businessDescription':
                                      businessDescriptionController.text.trim(),

                                  // Add other necessary fields here
                                };

                                try {
                                  var response = await http.post(
                                    Uri.parse('http://10.0.2.2:8000/users/b'),
                                    headers: {
                                      'Content-Type':
                                          'application/json; charset=UTF-8',
                                    },
                                    body: jsonEncode(userData),
                                  );

                                  final responseData =
                                      jsonDecode(response.body);
                                  final userId = responseData['userId'];
                                  // If server returns 200 OK response, navigate to success screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Vehicledetails1(userId: userId),
                                    ),
                                  );
                                } catch (e) {
                                  print('Error: $e');
                                  _showFillMessage(
                                    'Error! Please try again later.',
                                  );
                                }
                                // Call function to save vehicle details
                              }
                            : null,
                        style: ButtonStyle(
                          padding:
                              WidgetStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          ),
                          backgroundColor: WidgetStateProperty.all<Color>(
                            const Color(0xFFFF5C01),
                          ),
                        ),
                        child: const Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
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
