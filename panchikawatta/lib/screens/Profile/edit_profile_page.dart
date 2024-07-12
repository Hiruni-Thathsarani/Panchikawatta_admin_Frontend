import 'package:flutter/material.dart';
import 'package:panchikawatta/components/custom_button.dart';
import 'package:panchikawatta/components/drop_down_input_fields.dart';
import 'package:panchikawatta/components/input_fields.dart';
import 'dart:io';
import 'package:panchikawatta/screens/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _image; //create a File object to store the image
  final formKey = GlobalKey<FormState>();

  //these are for chat application testing purpose. remove when done.
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  //String? imagePath = _image?.path;

  @override
  Widget build(BuildContext context) {
    String? imagePath =
        _image?.path; // to send the profile picture to the firestrore

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
        //   onPressed: () {
        //     // Navigate to the add vehicle pageddddd
        //     Navigator.pop(context);
        //   },
        // ),
        title: const Text('Edit Profile',
            style: TextStyle(color: Color(0xFFFF5C01), fontSize: 28)),
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 20,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      height: 150,
                      width: 160,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: _image != null
                                  ? FileImage(_image!) as ImageProvider<Object>
                                  : null, //const AssetImage('lib/assets/profilePicture.jpg') as ImageProvider<Object>,
                              child: _image != null
                                  ? null
                                  : const Icon(Icons.person, size: 80),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              icon: const Icon(Icons.file_upload,
                                  color: Colors.black, size: 30),
                              onPressed: () async {
                                final selectedImage = await showDialog<File>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ImagePickerPage();
                                  },
                                );
                                setState(() {
                                  _image = selectedImage;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.1, // left
                      0, // top
                      MediaQuery.of(context).size.width * 0.1, // right
                      0, // bottom
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InputFields(
                                    hintText: 'First Name',
                                    width1: 0.38,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        _showFillMessage(
                                            "Please enter your first name");
                                      }
                                      return null;
                                    }),
                                InputFields(
                                    hintText: 'Last Name',
                                    width1: 0.38,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        _showFillMessage(
                                            "Please enter your last name");
                                      }
                                      return null;
                                    }),
                              ],
                            ),
                            const SizedBox(height: 15),
                            InputFields(
                              hintText: 'Username',
                              width1: 0.8,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  _showFillMessage(
                                      "Please enter your Username");
                                }
                                return null;
                              },
                              controller: _name,
                            ),
                            const SizedBox(height: 15),
                            InputFields(
                              hintText: 'Password',
                              width1: 0.8,
                              validator: (value) {
                                // (?=.*[a-z]): at least one lowercase letter
                                // (?=.*[A-Z]): at least one uppercase letter
                                // (?=.*\d): at least one digit
                                // (?=.*[@$!%*?&#]): at least one special character
                                // [A-Za-z\d@$!%*?&]{8,}: at least 8 characters
                                Pattern pattern =
                                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$';
                                RegExp regex = RegExp(pattern as String);

                                if (value == null || value.isEmpty) {
                                  _showFillMessage(
                                      "Please enter your password");
                                } else if (!regex.hasMatch(value)) {
                                  _showFillMessage(
                                      "Your password is not strong enough.A strong password should be 8+ characters long, with at least one uppercase letter, one lowercase letter, one digit, and one special character.");
                                }
                                return null;
                              },
                              controller: _password,
                            ),
                            const SizedBox(height: 15),
                            InputFields(
                              validator: (value) {
                                String emailPattern =
                                    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+'; //format: username@domain.extension.
                                RegExp emailRegex = RegExp(emailPattern);

                                if (value!.isEmpty) {
                                  _showFillMessage(
                                      "Please enter your email address");
                                }

                                if (!emailRegex.hasMatch(value!)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              hintText: 'Email',
                              width1: 0.8,
                              controller: _email,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.25, // adjust as needed
                                  color: const Color(
                                      0xFFFAFAFA), // to visualize the container
                                  child: DropdownInputField(
                                    // use the custom DropdownInputField widget
                                    dropdownItems: const ['+94'],
                                    hintText: '+94',
                                    initialValue: '+94',
                                  ),
                                ),
                                InputFields(
                                  hintText: '',
                                  width1: 0.5,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _showFillMessage(
                                          'Please enter a phone number');
                                    }
                                    // Check if the phone number is valid
                                    final phoneRegExp = RegExp(r'^\d{9}$');
                                    if (!phoneRegExp.hasMatch(value!)) {
                                      return 'Please enter a valid phone number';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.38, // adjust as needed
                                  color: const Color(
                                      0xFFFAFAFA), // to visualize the container
                                  child: DropdownInputField(
                                    // use the custom DropdownInputField widget
                                    dropdownItems: const [
                                      'Ampara',
                                      'Anuradhapura',
                                      'Badulla',
                                      'Batticaloa',
                                      'Colombo',
                                      'Galle',
                                      'Gampaha',
                                      'Hambantota',
                                      'Jaffna',
                                      'Kalutara',
                                      'Kandy',
                                      'Kegalle',
                                      'Kilinochchi',
                                      'Kurunegala',
                                      'Mannar',
                                      'Matale',
                                      'Matara',
                                      'Monaragala',
                                      'Mullaitivu',
                                      'Nuwara Eliya',
                                      'Polonnaruwa',
                                      'Puttalam',
                                      'Ratnapura',
                                      'Trincomalee',
                                      'Vavuniya'
                                    ],
                                    hintText: 'District',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        _showFillMessage(
                                            "Please enter your province");
                                      }
                                      return null;
                                    },
                                    // initialValue: 'Colombo',
                                  ),
                                ),

                                //"'package:flutter/src/material/dropdown.dart':Failed assertion:line 1619 pos 15: 'items == null || items.isEmpty || value == null || items.

                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.38, // adjust as needed
                                  color: const Color(
                                      0xFFFAFAFA), // to visualize the container
                                  child: DropdownInputField(
                                    // use the custom DropdownInputField widget
                                    dropdownItems: const [
                                      'Central',
                                      'Eastern',
                                      'North Central',
                                      'Northern',
                                      'North Western',
                                      'Sabaragamuwa',
                                      'Southern',
                                      'Uva',
                                      'Western'
                                    ],
                                    hintText: 'Province',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        _showFillMessage(
                                            "Please enter your province");
                                      }
                                      return null;
                                    },
                                    // initialValue: 'Western',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            CustomButton(
                              onPressed: () {
                                // // Navigate to the add vehicle page
                                // submitForm();

                                //   if (_name.text.isNotEmpty &&
                                //       _email.text.isNotEmpty &&
                                //       _password.text.isNotEmpty) {
                                //         setState(() {
                                //           isLoading = true;
                                //         });

                                //         createAccount(_name.text, _email.text, _password.text, imagePath).then((user) {
                                //           if (user != null) {
                                //             setState(() {
                                //               isLoading = false;
                                //             });
                                //             print("Account created successfully");
                                //             Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen()));
                                //           } else {
                                //             setState(() {
                                //               isLoading = false;
                                //             });
                                //             print("Account creation failed");
                                //           }
                                //         });
                                //   } else {
                                //     _showFillMessage("Please fill all the fields");
                                //   }
                              },
                              text: 'Save',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      // Continue with form submission
    }
  }

  //A function for showing alerts. copied from dinithi
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
}
