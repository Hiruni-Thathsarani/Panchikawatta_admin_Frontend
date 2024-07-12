// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panchikawatta/components/custom_button.dart';
import 'package:panchikawatta/components/add_image.dart';
import 'package:panchikawatta/screens/AdPost/post_success.dart';
import 'package:panchikawatta/services/post_api_service.dart';

class ServicePost extends StatefulWidget {
  ServicePost({super.key});

  @override
  _ServicePostState createState() => _ServicePostState();
  final PostApiService apiService = PostApiService();
}

class _ServicePostState extends State<ServicePost> {
  final List<XFile?> _images = List<XFile?>.filled(1, null);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _setImage(int index, XFile? image) {
    setState(() {
      _images[index] = image;
    });
  }

  Future<void> _postService() async {
    try {
      final title = _titleController.text;
      final description = _descriptionController.text;
      final image = _images[0];
      const int sellerId = 1; // Replace this with the actual seller ID

      // Debug prints to check the values
      print('Title: $title');
      print('Description: $description');
      print('Image: ${image?.path}');

      if (title.isEmpty || description.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all required fields')),
        );
        return;
      }

      final response = await widget.apiService.postService(
        sellerId: sellerId,
        title: title,
        description: description,
        image: image,
      );

      // Debug print response
      print('Response: ${response.toString()}');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PostSuccess(),
        ),
      );
    } catch (e) {
      print('Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post service: $e')),
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
          'Post Service Ad',
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
                    const Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFEBEBEB),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    const Text(
                      'Add Image',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: CustomButton(
                  onPressed: () async {
                    await _postService();
                  },
                  text: 'Post Ad',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
