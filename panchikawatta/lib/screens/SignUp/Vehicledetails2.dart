import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:panchikawatta/components/custom_button.dart';
import 'package:panchikawatta/components/drop_down_input_fields.dart';
import 'package:panchikawatta/components/input_fields.dart';
import 'package:panchikawatta/main.dart';
import 'package:http/http.dart' as http;
import 'package:panchikawatta/screens/SignUp/Vehicledetails1.dart';

class Vehicledetails2 extends StatefulWidget {
  final int vehicleId, userId;

  final String? selectedPhotoPath;

  Vehicledetails2({
    Key? key,
    required this.vehicleId,
    required this.userId,
    this.selectedPhotoPath,
    String? type,
  }) : super(key: key);

  @override
  _Vehicledetails2State createState() => _Vehicledetails2State();
}

class _Vehicledetails2State extends State<Vehicledetails2> {
  String? selectedPhotoPath;
  TextEditingController milagePerWeekController = TextEditingController();

  TextEditingController lastServiceDateController = TextEditingController();
  //TextEditingController batteryConditionController = TextEditingController();
  String? selectedBatteryCondition;
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
  void initState() {
    super.initState();
    selectedPhotoPath = widget.selectedPhotoPath;
  }

  // Navigate to MyHomePage
  void _saveVehicleDetails() async {
    // Validate and parse mileage per week
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding:
              EdgeInsets.only(left: 80.0), // Adjust the value as needed
          child: Text(
            'Vehicle Details',
            style: TextStyle(color: Color(0xFFFF5C01), fontSize: 28),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 150,
                width: 200,
                child: Stack(
                  children: [
                    if (selectedPhotoPath != null)
                      Positioned.fill(
                        child: Image.file(
                          File(selectedPhotoPath!),
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Positioned.fill(
                        child: Image.asset(
                          'lib/src/img/vehicleDetails.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.1,
                0,
                MediaQuery.of(context).size.width * 0.1,
                0,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputFields(
                      controller: milagePerWeekController,
                      hintText: 'Mileage',
                      width1: 0.8,
                    ),
                    const SizedBox(height: 20),
                    InputFields(
                      controller: lastServiceDateController,
                      hintText: 'Last Service date',
                      width1: 0.8,
                    ),
                    const SizedBox(height: 20),
                    DropdownInputField(
                      value: selectedBatteryCondition,
                      hintText: 'Battery Condition',
                      dropdownItems: ['Excellent', 'Good', 'Fair', 'Low'],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ClipRRect(
                        child: TextButton(
                          onPressed: () {
                            final userId = widget.userId;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Vehicledetails1(userId: userId),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            padding:
                                WidgetStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 249, 248, 247),
                            ),
                          ),
                          child: const Text(
                            "+ Add Vehicle",
                            style: TextStyle(
                              color: Color.fromARGB(255, 234, 137, 9),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage()),
                            );
                          },
                          text: 'skip',
                        ),
                        CustomButton(
                          onPressed: () async {
                            // Validate and parse mileage per week
                            int mileage =
                                0; // Default value if parsing fails or input is empty
                            String mileageText =
                                milagePerWeekController.text.trim();

                            if (mileageText.isNotEmpty) {
                              try {
                                mileage = int.parse(mileageText);
                              } catch (e) {
                                // Handle parsing error (e.g., show error message to user)
                                print('Error parsing mileage: $e');
                                _showFillMessage(
                                    'Invalid mileage value entered.');
                                return; // Exit function early to prevent further execution
                              }
                            }

                            // Check if any of the required fields are empty
                            if (milagePerWeekController.text.isEmpty &&
                                lastServiceDateController.text.isEmpty &&
                                selectedBatteryCondition == null) {
                              _showFillMessage(
                                  "Please fill in at least one field to save details");
                              return; // Exit function if validation fails
                            }

                            // Prepare data to be sent to the server
                            Map<String, dynamic> userData = {
                              'vehicleId': widget.vehicleId,
                              'mileagePerWeek': mileage,
                              'lastServiceDate':
                                  lastServiceDateController.text.trim(),
                              'batteryCondition':
                                  selectedBatteryCondition ?? '',
                              // Add other necessary fields here
                            };

                            try {
                              var response = await http.post(
                                Uri.parse('http://10.0.2.2:8000/users/uv'),
                                headers: {
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: jsonEncode(userData),
                              );

                              // Handle success response
                              handlePopup(
                                  context, widget.vehicleId, widget.userId);
                            } catch (e) {
                              // Handle network or server errors
                              print('Error: $e');
                              _showFillMessage(
                                'Error updating vehicle. Please try again later.',
                              );
                            }
                          },
                          text: 'Save',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void handlePopup(BuildContext context, int vehicleId, int userId) {
  showDialog(
    context: context,
    barrierDismissible:
        false, // Do not allow dismissing dialog by tapping outside or using back button
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add More Vehicles'),
        content: const Text('Do you want to add more vehicles?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(), // Navigate to MyHomePage
                ),
              );
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Vehicledetails2(vehicleId: vehicleId, userId: userId),
                ),
              );
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
