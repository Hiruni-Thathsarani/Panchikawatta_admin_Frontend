import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panchikawatta/screens/SignUp/Vehicledetails2.dart';
import 'package:panchikawatta/components/custom_button.dart';
import 'package:panchikawatta/components/input_fields.dart';
import 'package:http/http.dart' as http;
import 'package:panchikawatta/screens/auth_functions.dart';

Map<String, List<String>> vehicleMakes = {
  'Car': ['Toyota', 'Honda', 'Nissan'],
  'Motorcycle': ['Honda', 'Yamaha', 'Suzuki'],
  'Three-Wheeler (Tuk Tuk)': ['Bajaj', 'Piaggio', 'TVS'],
  'Truck': ['Ford', 'Chevrolet', 'Dodge'],
  'Bus': ['Volvo', 'Mercedes-Benz', 'MAN'],
  'Van': ['Ford Transit', 'Mercedes-Benz Sprinter', 'Toyota Hiace'],
  'SUV': ['Jeep', 'Ford', 'Land Rover'],
  'Pickup Truck': ['Ford F-150', 'Chevrolet Silverado', 'Toyota Tacoma'],
};

Map<String, List<String>> vehicleModels = {
  'Toyota': ['Corolla', 'Camry', 'Rav4'],
  'Honda': ['Civic', 'Accord', 'CR-V'],
  'Nissan': ['Altima', 'Sentra', 'Rogue'],
  'Ford': ['Fusion', 'Escape', 'Explorer'],
  'Chevrolet': ['Malibu', 'Equinox', 'Tahoe'],
  'Dodge': ['Charger', 'Durango', 'Ram 1500'],
  'Jeep': ['Wrangler', 'Grand Cherokee', 'Cherokee'],
  'Land Rover': ['Range Rover', 'Discovery', 'Defender'],
};

List<String> vehicleTypes = [
  'Car',
  'Motorcycle',
  'Three-Wheeler (Tuk Tuk)',
  'Truck',
  'Bus',
  'Van',
  'SUV',
  'Pickup Truck',
  'Convertible',
  'Hatchback',
];

class Vehicledetails1 extends StatefulWidget {
  final int userId;
  final int vehicleId;
  Vehicledetails1({required this.userId, this.vehicleId = 0});

  @override
  _AddVehicleDetailsState createState() => _AddVehicleDetailsState();
}

class _AddVehicleDetailsState extends State<Vehicledetails1> {
  final ImagePicker _picker = ImagePicker();
  //String? selectedPhotoPath;
  String? selectedtype;
  String? selectedmake;
  String? selectedmodel;
  String? imagePath;
  TextEditingController yearController = TextEditingController();
  TextEditingController licenceDateController = TextEditingController();
  TextEditingController insuranceDateController = TextEditingController();

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

  Future<void> _uploadFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
      await uploadVehiclePhoto(widget.userId.toString(), imagePath!);
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() async {
        imagePath = pickedFile.path;
        await uploadVehiclePhoto(widget.userId.toString(), imagePath!);
      });
    }
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  // Validate all required fields

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
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
                    if (imagePath != null)
                      Positioned.fill(
                        child: Image.file(
                          File(imagePath!),
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
                    Positioned(
                      bottom: -20,
                      right: -10,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconButton(
                          icon: const Icon(Icons.file_upload,
                              color: Colors.black, size: 30),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Upload Options"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: const Icon(Icons.photo_library),
                                        title: const Text('Upload from Gallery'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          _uploadFromGallery();
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.camera_alt),
                                        title: const Text('Take a Photo'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          _takePhoto();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.1, // left
                0, // top
                MediaQuery.of(context).size.width * 0.1, // right
                0, // bottom
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Dropdown for Type
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedtype,
                            hint: const Text('Type'),
                            onChanged: (value) {
                              setState(() {
                                selectedtype = value;
                                selectedmake =
                                    null; // Reset selected make when type changes
                              });
                            },
                            items: vehicleTypes.map((type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedmake,
                            hint: const Text('Make'),
                            onChanged: (value) {
                              setState(() {
                                selectedmake = value;
                                selectedmodel =
                                    null; // Reset selected model when make changes
                              });
                            },
                            items: selectedtype != null &&
                                    vehicleMakes[selectedtype!] != null
                                ? vehicleMakes[selectedtype!]!.map((make) {
                                    return DropdownMenuItem<String>(
                                      value: make,
                                      child: Text(make),
                                    );
                                  }).toList()
                                : [],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Dropdown for Model
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedmodel,
                            hint: const Text('Model'),
                            onChanged: (value) {
                              setState(() {
                                selectedmodel = value;
                              });
                            },
                            items: selectedmake != null &&
                                    vehicleModels[selectedmake!] != null
                                ? vehicleModels[selectedmake!]!.map((model) {
                                    return DropdownMenuItem<String>(
                                      value: model,
                                      child: Text(model),
                                    );
                                  }).toList()
                                : [],
                          ),
                        ),

                        InputFields(
                          controller: yearController,
                          hintText: 'year',
                          width1: 0.38,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Divider(
                        color: Colors.black,
                        thickness: 0.5,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'License Renewal Date',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    InputFields(
                      controller: licenceDateController,
                      hintText: 'DD/MM/YY',
                      width1: 0.8,
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                        size: 24,
                      ),
                      onPressed: () =>
                          _selectDate(context, licenceDateController),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Vehicle insurance renewal date',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    InputFields(
                      controller: insuranceDateController,
                      hintText: 'DD/MM/YY',
                      width1: 0.8,
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                        size: 24,
                      ),
                      onPressed: () =>
                          _selectDate(context, insuranceDateController),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          onPressed: () {
                            int vehicleId = widget.vehicleId;
                            final userId = widget.userId;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Vehicledetails2(
                                      vehicleId: vehicleId, userId: userId)),
                            );
                          },
                          text: 'Skip',
                        ),
                        CustomButton(
                          onPressed: () async {
                            if (yearController.text.isEmpty &&
                                selectedtype == null &&
                                selectedmake == null &&
                                selectedmodel == null &&
                                licenceDateController.text.isEmpty &&
                                insuranceDateController.text.isEmpty) {
                              _showFillMessage(
                                  "Please fill   field to save details");
                            } else {
                              // Proceed with saving the data
                              Map<String, dynamic> userData = {
                                'userId': widget.userId,
                                'type': selectedtype,
                                'make': selectedmake,
                                'model': selectedmodel,
                                'year':
                                    int.tryParse(yearController.text.trim()) ??
                                        0,
                                'licenceDate':
                                    licenceDateController.text.trim(),
                                'insuranceDate':
                                    insuranceDateController.text.trim(),
                                // Add other necessary fields here
                              };

                              try {
                                var response = await http.post(
                                  Uri.parse('http://10.0.2.2:8000/users/cv'),
                                  headers: {
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(userData),
                                );

                                if (response.statusCode == 201) {
                                  final responseData =
                                      jsonDecode(response.body);
                                  int vehicleId = responseData['vehicleId'];
                                  final userId = widget.userId;
                                  // If server returns 201 Created response, navigate to success screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Vehicledetails2(
                                        vehicleId: vehicleId,
                                        userId: userId,
                                      ),
                                    ),
                                  );
                                } else {
                                  // Handle other HTTP status codes if needed
                                  _showFillMessage(
                                      "Error: ${response.statusCode}");
                                }
                              } catch (e) {
                                print('Error: $e');
                                _showFillMessage(
                                  'Error registering vehicle. Please try again later.',
                                );
                              }
                            }

                            if (imagePath != null) {
                              await uploadVehiclePhoto(
                                  widget.userId.toString(), imagePath!);
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
