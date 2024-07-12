// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:panchikawatta/components/custom_button.dart';
import 'package:panchikawatta/components/input_fields.dart';


class AddVehicleDetails extends StatefulWidget {
  @override
  _AddVehicleDetailsState createState() => _AddVehicleDetailsState();
}

class _AddVehicleDetailsState extends State<AddVehicleDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () {
            // Navigate to the add vehicle page
          },
        ),
        title: const Text('Vehicle Details', style: TextStyle(color: Color(0xFFFF5C01), fontSize: 28)),
      ),
      
      
      //body of the page
      body: SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 150,
                width: 200,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset('lib/assets/vehicleDetails.jpeg', fit: BoxFit.cover,),
                    ),
                    
                    //A button to upload the vehicle image
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: const Icon(Icons.file_upload, color: Colors.black, size: 30),
                        onPressed: () {
                          // Navigate to the add vehicle page
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.1,  // left
                0,                                        // top
                MediaQuery.of(context).size.width * 0.1,  // right
                0,                                        // bottom
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InputFields(hintText: 'Vehicle Name', width1: 0.8),
                    
                    const SizedBox(height: 15),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InputFields(hintText: 'Type', width1: 0.38, suffixIcon: Icon(Icons.expand_more, size: 30, color: Color(0xCC000000))),
                        InputFields(hintText: 'Make', width1: 0.38, suffixIcon: Icon(Icons.expand_more, size: 30, color: Color(0xCC000000))),
                      ],
                    ),

                    const SizedBox(height: 15),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InputFields(hintText: 'Model', width1: 0.38, suffixIcon: Icon(Icons.expand_more, size: 30, color: Color(0xCC000000))),
                        InputFields(hintText: 'Year', width1: 0.38,),
                      ],
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Divider(
                        color: Colors.black,
                        thickness: 1,
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
                    const InputFields(hintText: 'DD/MM/YY', width1: 0.8, suffixIcon: Icon(Icons.calendar_today)),

                    const SizedBox(height: 15),

                    const Text(
                      'Vehicle insurance renewal date',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const InputFields(hintText: 'DD/MM/YY', width1: 0.8, suffixIcon: Icon(Icons.calendar_today)),

                    const SizedBox(height: 40),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          onPressed: () {
                            // Add your button press logic here
                          },
                          text: 'Skip',
                        ),
                        CustomButton(
                          onPressed: () {
                            // Add your button press logic here
                          },
                          text: 'Next',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Add other widgets below if needed
          ],
        ),
      ),
    );
  }
}