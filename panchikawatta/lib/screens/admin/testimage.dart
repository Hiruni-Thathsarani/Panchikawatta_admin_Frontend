import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdminImageUploadWidget extends StatefulWidget {
  final String adminID;

  const AdminImageUploadWidget({Key? key, required this.adminID}) : super(key: key);

  @override
  _AdminImageUploadWidgetState createState() => _AdminImageUploadWidgetState();
}

class _AdminImageUploadWidgetState extends State<AdminImageUploadWidget> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      // Create a reference to the location you want to upload to in Firebase Storage
      String fileName = 'admin_images/${widget.adminID}/${DateTime.now().millisecondsSinceEpoch.toString()}.png';
      Reference storageReference = FirebaseStorage.instance.ref().child(fileName);

      // Upload the file
      UploadTask uploadTask = storageReference.putFile(_image!);
      await uploadTask;

      // Get the download URL of the uploaded file
      String downloadURL = await storageReference.getDownloadURL();

      print('Image uploaded successfully. Download URL: $downloadURL');
      // Handle success, maybe show a success message or update UI
    } on FirebaseException catch (e) {
      print('Error uploading image: $e');
      // Handle error, maybe show an error message or retry logic
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Admin Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}