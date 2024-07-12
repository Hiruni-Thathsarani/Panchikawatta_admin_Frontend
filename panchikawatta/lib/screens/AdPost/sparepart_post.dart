// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panchikawatta/components/custom_button.dart';
import 'package:panchikawatta/components/add_image.dart';
import 'package:panchikawatta/screens/AdPost/post_unsuccess.dart';
import 'package:panchikawatta/services/post_api_service.dart';
import 'package:panchikawatta/dropdowns/condition_post.dart';
import 'package:panchikawatta/dropdowns/fuel_post.dart';
import 'package:panchikawatta/dropdowns/origin.dart';
import 'package:panchikawatta/dropdowns/vehicle_make.dart';
import 'package:panchikawatta/dropdowns/vehicle_model.dart';
import 'package:panchikawatta/screens/AdPost/post_success.dart';

class AdPost extends StatefulWidget {
  AdPost({super.key});

  @override
  _AdPostState createState() => _AdPostState();
  final PostApiService apiService = PostApiService();
}

class _AdPostState extends State<AdPost> {
  final List<XFile?> _images = List<XFile?>.filled(1, null);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? _selectedMake;
  String? _selectedModel;
  String? _selectedOrigin;
  String? _selectedCondition;
  String? _selectedFuel;
  final TextEditingController _yearController = TextEditingController();

  void _setImage(int index, XFile? image) {
    setState(() {
      _images[index] = image;
    });
  }

  Future<void> _postSparePart() async {
    try {
      final title = _titleController.text;
      final description = _descriptionController.text;
      final price = int.tryParse(_priceController.text);
      final image = _images[0];
      final make = _selectedMake;
      final model = _selectedModel;
      final origin = _selectedOrigin;
      final condition = _selectedCondition;
      final fuel = _selectedFuel;
      final year = int.tryParse(_yearController.text);

      if (title.isEmpty ||
          description.isEmpty ||
          price == null ||
          make == null ||
          model == null ||
          origin == null ||
          condition == null ||
          fuel == null ||
          year == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all required fields')),
        );
        print('Title: $title');
        print('Description: $description');
        print('Price: $price');
        print('Image: $image');
        print('Make: $make');
        print('Model: $model');
        print('Origin: $origin');
        print('Condition: $condition');
        print('Fuel: $fuel');
        print('Year: $year');
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PostSuccess()),
      );
    } catch (e) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PostUnsuccess()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post ad: $e')),
      );
    }
  }

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
          'Post Ad',
          style: TextStyle(
            color: Color(0xFFFF5C01),
            fontSize: 27,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Title',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Color(0xCC000000),
                          fontWeight: FontWeight.normal,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFEBEBEB),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Description',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Color(0xCC000000),
                          fontWeight: FontWeight.normal,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFEBEBEB),
                      ),
                      minLines: 3,
                      maxLines: null,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Price',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Color(0xCC000000),
                          fontWeight: FontWeight.normal,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFEBEBEB),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Add Image',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(1, (index) {
                  return AddImage(
                    size: 70,
                    color: const Color(0xFF999999),
                    onImageSelected: (image) => _setImage(index, image),
                  );
                }),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: VehicleMake(
                            selectedMake: _selectedMake,
                            onChanged: (String? make) {
                              setState(() {
                                _selectedMake = make;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: VehicleModel(
                            selectedModel: _selectedModel,
                            models: vehicleMakeToModels[_selectedMake] ?? [],
                            onChanged: (String? model) {
                              setState(() {
                                _selectedModel = model;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _yearController,
                            decoration: const InputDecoration(
                              hintText: 'Year',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Color(0xCC000000),
                                fontWeight: FontWeight.normal,
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: OriginDropdown(
                            onChanged: (value) {
                              setState(() {
                                _selectedOrigin = value;
                              });
                            },
                            selectedOrigin: _selectedOrigin,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Condition(
                            onChanged: (value) {
                              setState(() {
                                _selectedCondition = value;
                              });
                            },
                            selectedCondition: _selectedCondition,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Fuel(
                            onChanged: (value) {
                              setState(() {
                                _selectedFuel = value;
                              });
                            },
                            selectedFuel: _selectedFuel,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: CustomButton(
                        onPressed: () async {
                          await _postSparePart();
                        },
                        text: 'Submit',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
