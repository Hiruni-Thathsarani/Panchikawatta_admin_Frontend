import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_cropper/image_cropper.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  File? _image;

  Future<void> _pickImageFromCamera() async {
    final returenedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(returenedImage!.path);
    });

    if (returenedImage != null) {
      Navigator.pop(context, File(returenedImage.path));
    }
  }

  Future _pickImageFromGallery() async {
    final returenedImage = await ImagePicker().pickImage(source: ImageSource.gallery);  

    setState(() {
      _image = File(returenedImage!.path);
    });

    if (returenedImage != null) {
      Navigator.pop(context, File(returenedImage.path));
    }
  }

  // Future<void> _pickImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     await Future.delayed(const Duration(milliseconds: 500));

  //     final cropper = ImageCropper();

  //     // final croppedImage = await cropper.cropImage(
  //     //   sourcePath: image.path,
  //     //   aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0), // For square crop
  //     //   compressQuality: 100,
  //     //   maxWidth: 700,
  //     //   maxHeight: 700,
  //     //   compressFormat: ImageCompressFormat.jpg,
  //     //   androidUiSettings: const AndroidUiSettings(
  //     //     toolbarColor: Colors.orange,
  //     //     toolbarTitle: "Crop Image",
  //     //     statusBarColor: Colors.deepOrange,
  //     //     backgroundColor: Colors.white,
  //     //   ),
  //     // );

  //     // if (croppedImage != null) {
  //     //   setState(() {
  //     //     _image = XFile(croppedImage.path);
  //     //   });
  //     // }

  //     try {
  //       final croppedImage = await cropper.cropImage(
  //         sourcePath: image.path,
  //             aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0), // For square crop
  //             compressQuality: 100,
  //             maxWidth: 700,
  //             maxHeight: 700,
  //             compressFormat: ImageCompressFormat.jpg,
  //             androidUiSettings: const AndroidUiSettings(
  //               toolbarColor: Colors.orange,
  //               toolbarTitle: "Crop Image",
  //               statusBarColor: Colors.deepOrange,
  //               backgroundColor: Colors.white,
  //             ),
  //       );

  //       if (croppedImage != null) {
  //         setState(() {
  //           _image = XFile(croppedImage.path);
  //         });
  //       }
  //     } catch (e) {
  //       print('Error cropping image: $e');
  //     }

  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width * 0.9,
        child:  Padding(
          padding: const EdgeInsets.fromLTRB(
            20,   //left, 
            20,  // top, 
            20,  // right, 
            20,  // bottom
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.camera_alt, color: Color(0xFF000000), size: 32,),
                        onPressed: () {
                          // Add your button press logic here
                          _pickImageFromCamera();
                        },
                      ),
                      const Text('Camera', style: TextStyle(fontSize: 16, color: Color(0xFF000000))),
                    ],
                  ),

                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.collections, color: Color(0xFF000000), size: 32,),
                        onPressed: () {
                          // Add your button press logic here
                          // _pickImage();
                          _pickImageFromGallery();
                        },
                      ),
                      const Text('Gallery', style: TextStyle(fontSize: 16, color: Color(0xFF000000))),
                    ],
                  ),

                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Color(0xFF000000), size: 33,),
                        onPressed: () {
                          // Add your button press logic here
                          setState(() {
                            _image = null;
                          });
                          Navigator.pop(context, null);
                        },
                      ),
                      const Text('Delete', style: TextStyle(fontSize: 16, color: Color(0xFF000000))),
                    ],
                  ),

                ]
              )
            ],
          ),
      ),
      ),
    );
  }
}