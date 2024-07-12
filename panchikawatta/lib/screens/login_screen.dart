// // import 'dart:async';
// // import 'dart:convert';
// // import 'dart:io';
// // import 'dart:math';

// // import 'package:http/http.dart' as http;
// // import 'package:panchikawatta/screens/Vehicledetails2.dart';
// // import 'package:panchikawatta/screens/login.dart';
// // import 'package:panchikawatta/screens/sign_up1.dart';
// import 'package:flutter/material.dart';
// import 'package:panchikawatta/screens/chat_screen.dart';
// // import 'package:panchikawatta/screens/Vehicledetails1.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _SignUp2State();
//   }
// }

// class _SignUp2State extends State<LoginScreen> {
//   String? imagePath;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController Business_NameController = TextEditingController();
//   final TextEditingController Business_AddressController = TextEditingController();
//   final TextEditingController Business_contact_noController = TextEditingController();
//   final TextEditingController Business_descriptionController = TextEditingController();
//   final TextEditingController firstNameController = TextEditingController();
  
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     Map<String, String?>? data =
//         ModalRoute.of(context)!.settings.arguments as Map<String,String?>?;
 
//     String fname = data?['firstname'] ?? '';
//     String lname = data?['lastname'] ?? '';
//     String username = data?['username'] ?? '';  
//     String password = data?['password'] ?? '';
//     String email = data?['email'] ?? '';
//     String phoneno = data?['phoneno'] ?? '';
//     String? district = data?['district'];
//     String? province = data?['province'];

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 25),
//           child: Column(
//             children: <Widget>[
//               SizedBox(height: 40),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                 child: Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Icon(Icons.arrow_back),
//                     ),
//                     SizedBox(width: 10),
//                     Text(
//                       "Fill your Profile",
//                       style: TextStyle(
//                         color: Color(0xFFFF5C01),
//                         fontSize: 28,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
//                 child: Text(
//                   "If you want to sell, fill this out",
//                   style: TextStyle(
//                     color: Color(0xFF000000),
//                     fontSize: 18,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//               TextFieldContainer(
//                 child: TextField(
//                   controller: Business_NameController,
//                   cursorColor: Colors.black,
//                   decoration: InputDecoration(
//                     hintText: "Business Name",
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//               TextFieldContainer(
//                 child: TextField(
//                   controller: Business_AddressController,
//                   cursorColor: Colors.black,
//                   decoration: InputDecoration(
//                     hintText: "Business Address",
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//               TextFieldContainer(
//                 child: TextField(
//                   cursorColor: Colors.black,
//                   controller: Business_contact_noController,
//                   decoration: InputDecoration(
//                     hintText: "Business contact no",
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//               TextFieldContainer(
//                 child: TextField(
//                   cursorColor: Colors.black,
//                   controller: Business_descriptionController,
//                   decoration: InputDecoration(
//                     hintText: "Business description",
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     width: size.width * 0.3,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(29),
//                       child: TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ChatScreen() ),
//                                     // Vehicledetails1()),  
//                           );
//                         },
//                         style: ButtonStyle(
//                           padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                             EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                           ),
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                             Color.fromARGB(255, 246, 111, 38),
//                           ),
//                         ),
//                         child: Text(
//                           "Skip",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: size.width * 0.3,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(29),
//                       child: TextButton(
//                         onPressed: () {
                         
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>  ChatScreen(), //Vehicledetails1(), 
                                
//                                 settings: RouteSettings(
//                                   arguments: {
//                                   'Business_Name': Business_NameController.text,
//                                   'Business_Address': Business_AddressController.text,
//                                   'Business_contact_no': Business_contact_noController.text,
//                                   'Business_contact_no': Business_descriptionController.text,
//                                     'fname': fname,
                                  
//                                 }),
//                               ),
//                             );
                          
//                         },
//                         style: ButtonStyle(
//                           padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                             EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                           ),
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                             const Color(0xFFFF5C01),
//                           ),
//                         ),
//                         child: Text(
//                           "Next",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:panchikawatta/rest/rest_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:panchikawatta/screens/chat_screen.dart';
class EmailValidationResult {
  final bool isValid;
  final String message;

  EmailValidationResult(this.isValid, this.message);
}

class PhoneNumberValidationResult {
  final bool isValid;
  final String message;

  PhoneNumberValidationResult(this.isValid, this.message);
}

class LoginScreen extends StatefulWidget {



  @override
  _SignUp1State createState() => _SignUp1State();
}

class _SignUp1State extends State<LoginScreen> {
  String? imagePath;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController UsernameController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  String? selectedProvince;
  String? selectedDistrict;
@override


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

  String? validatePassword(String value) {
    // Password must contain at least one uppercase letter, one lowercase letter, one digit, one special character, and have a minimum length of 5 characters
    String pattern =
        r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#$&*])(?=.{5,})';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      if (value.length < 5) {
        return 'Password must have a minimum length of 5 characters';
      } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
        return 'Password must contain at least one uppercase letter';
      } else if (!RegExp(r'[a-z]').hasMatch(value)) {
        return 'Password must contain at least one lowercase letter';
      } else if (!RegExp(r'[0-9]').hasMatch(value)) {
        return 'Password must contain at least one digit';
      } else {
        return 'Password must contain at least one special character';
      }
    }
    return null; // Return null for valid passwords
  }

  Future<EmailValidationResult> isEmailValid(String email) async {
    try {
      if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
          .hasMatch(email)) {
        return EmailValidationResult(false, 'Invalid email format');
      }

      return EmailValidationResult(true, 'Email is valid');
    } catch (e) {
      return EmailValidationResult(false, 'Error verifying email: $e');
    }
  }

  PhoneNumberValidationResult validatePhoneNumber(String value) {
    // Phone number must be exactly 10 digits
    if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return PhoneNumberValidationResult(
          false, 'Phone number must be exactly 10 digits');
    }
    return PhoneNumberValidationResult(true, 'Phone number is valid');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 10),
                      const Text(
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
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 30),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[400],
                        child: ClipOval(
                          child: GestureDetector(
                            onTap: () async {
                              final imagePicker = ImagePicker();
                              final XFile? pickedFile =
                                  await imagePicker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (pickedFile != null) {
                                setState(() {
                                  imagePath = pickedFile.path;
                                });
                              }
                            },
                            child: imagePath != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        FileImage(File(imagePath!)),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey[400],
                                    child: Image.asset(
                                      'lib/src/img/profile.png',
                                      height: 250,
                                      width: 250,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -20,
                        right: -10,
                        child: Padding(
                          padding: const EdgeInsets.all(
                              10.0), // Add your desired padding here
                          child: GestureDetector(
                            onTap: () async {
                              final imagePicker = ImagePicker();
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext builder) {
                                  return SafeArea(
                                    child:  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                         ListTile(
                                          leading: const Icon(Icons.camera),
                                          title: const Text('Take Photo'),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            final XFile? pickedFile =
                                                await imagePicker.pickImage(
                                              source: ImageSource.camera,
                                            );
                                            if (pickedFile != null) {
                                              setState(() {
                                                imagePath = pickedFile.path;
                                              });
                                            }
                                          },
                                        ),
                                         ListTile(
                                          leading:
                                              const Icon(Icons.photo_library),
                                          title:
                                              const Text('Choose from Gallery'),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            final XFile? pickedFile =
                                                await imagePicker.pickImage(
                                              source: ImageSource.gallery,
                                            );
                                            if (pickedFile != null) {
                                              setState(() {
                                                imagePath = pickedFile.path;
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Image.asset(
                              'lib/src/img/uploadicon.png',
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 0.5, width: 40),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldContainer(
                        child: TextFormField(
                          controller: firstNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              _showFillMessage("Please enter your first name");
                              return null;
                            }
                            return null;
                          },
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            hintText: "First Name",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFieldContainer(
                        child: TextFormField(
                          controller: lastNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              _showFillMessage("Please enter your last name");
                              return null;
                            }
                            return null;
                          },
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            hintText: "Last Name",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TextFieldContainer(
                  child: TextFormField(
                    controller: UsernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _showFillMessage("Please enter a username");
                        return null;
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      hintText: "Username",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextFormField(
                    controller: PasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _showFillMessage("Please enter a password");
                        return null;
                      }
                      // Custom password validation
                      return validatePassword(value);
                    },
                    cursorColor: Colors.black,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _showFillMessage("Please enter an email");
                        return null;
                      }
                      if (!RegExp(
                              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                          .hasMatch(value)) {
                        // Display error message for invalid email format
                        return 'Invalid email format';
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextFormField(
                    controller: phoneNoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _showFillMessage("Please enter a phone number");
                        return null;
                      }
                      // Custom phone number validation
                      PhoneNumberValidationResult validationResult =
                          validatePhoneNumber(value);
                      if (!validationResult.isValid) {
                        // Display error message for invalid phone number
                        return validationResult.message;
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: "Phone (+94)",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: ' Province',
                          border: InputBorder.none, // Set the hint text here
                        ),
                        isExpanded: true,
                        value: selectedProvince, // Use the selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedProvince =
                                newValue; // Update the selected province
                          });
                        },
                        items: <String>[
                          'Western',
                          'Central',
                          'Southern',
                          'Northern',
                          'Eastern',
                          'North Western',
                          'North Central',
                          'Uva',
                          'Sabaragamuwa',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            _showFillMessage("Please select a province");
                            return null;
                          }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: ' District',
                          border: InputBorder.none, // Set the hint text here
                        ),
                        isExpanded: true,
                        value: selectedDistrict, // Use the selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDistrict =
                                newValue; // Update the selected district
                          });
                        },
                        items: <String>[
                          'Colombo',
                          'Gampaha',
                          'Kalutara',
                          'Kandy',
                          'Matale',
                          'Nuwara Eliya',
                          'Galle',
                          'Matara',
                          'Hambantota',
                          'Jaffna',
                          'Killinochchi',
                          'Mannar',
                          'Vavuniya',
                          'Mulaitivu',
                          'Batticaloa',
                          'Ampara',
                          'Trincomalee',
                          'Kurunegala',
                          'Puttalam',
                          'Anuradhapura',
                          'Polonnaruwa',
                          'Badulla',
                          'Monaragala',
                          'Ratnapura',
                          'Kegalle'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            _showFillMessage("Please select a district");
                            return null;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: size.width * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: TextButton(
                      onPressed: () async {
                        if (firstNameController.text.isNotEmpty &&
                          lastNameController.text.isNotEmpty &&
                          UsernameController.text.isNotEmpty &&
                          PasswordController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          phoneNoController.text.isNotEmpty) {
                        // doRegister(
                        //   firstNameController.text,
                        //         lastNameController.text,
                        //         UsernameController.text,
                        //         PasswordController.text,
                        //         emailController.text,
                        //         phoneNoController.text,
                        // );
                      } else {
                        Fluttertoast.showToast(
                          msg: 'All fields are required',
                          textColor: Colors.red,
                        );
                      }
                        // Check if any field is empty
                        if (firstNameController.text.isEmpty ||
                            lastNameController.text.isEmpty ||
                            UsernameController.text.isEmpty ||
                            PasswordController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            phoneNoController.text.isEmpty ||
                            selectedProvince == null ||
                            selectedDistrict == null) {
                          _showFillMessage("Please fill all required fields");
                        } else {
                          // Check password validity
                          String? passwordError =
                              validatePassword(PasswordController.text);
                          if (passwordError != null) {
                            _showFillMessage(passwordError);
                          } else {
                            // Perform email validation asynchronously
                            EmailValidationResult result =
                                await isEmailValid(emailController.text);
                            if (!result.isValid) {
                              // Show validation message if email is not valid
                              _showFillMessage(result.message,
                                  'Please enter a valid email');
                            } else {
                              // Custom phone number validation
                              PhoneNumberValidationResult phoneValidationResult =
                                  validatePhoneNumber(
                                      phoneNoController.text);
                              if (!phoneValidationResult.isValid) {
                                // Show validation message if phone number is not valid
                                _showFillMessage(phoneValidationResult.message,
                                    'Please enter a valid phone number');
                              } else {
                                // If all fields are filled and email is valid, navigate to next screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(),
                                    settings: RouteSettings(
                                      arguments: {
                                        'firstName': firstNameController.text,
                                        'lastName': lastNameController.text,
                                        'Username': UsernameController.text,
                                        'Password': PasswordController.text,
                                        'email': emailController.text,
                                        'phoneNo': phoneNoController.text,
                                        'province': selectedProvince,
                                        'district': selectedDistrict
                                      },
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                        }
                      },
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        ),
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color(0xFFFF5C01)),
                      ),

                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        "Already have an Account?",
                        style: TextStyle(
                          color: Color(0xFF000000),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatScreen()),
                        );
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xFFFF5C01),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onEnter: (PointerEnterEvent event) {},
                        onExit: (PointerExitEvent) {},
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
//   void doRegister(
//     String firstName,
//     String  lastName,
//     String Username,
//     String Password,
//     String email,
//     String phoneNo,
//   ) async {
//     var res = await userRegister(
//       firstName,
//        lastName,
//       Username,
//       Password,
//       email,
//       phoneNo,
//     );

//     print(res.toString());
//   }
}



// Widget TextFieldContainer({required TextField child}) {
//   return Container(
//     margin: EdgeInsets.symmetric(vertical: 10),
//     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//     decoration: BoxDecoration(
//       color: Colors.grey[200],
//       borderRadius: BorderRadius.circular(29),
//     ),
//     child: child,
//   );
// }

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  TextFieldContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}