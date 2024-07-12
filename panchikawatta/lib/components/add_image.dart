// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  final double size;
  final Color color;

  const AddImage({
    super.key,
    required this.size,
    required this.color,
    required void Function(dynamic image) onImageSelected,
  });

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: _image == null
          ? Icon(
              Icons.add_box_outlined,
              size: widget.size,
              color: widget.color,
            )
          : Image.file(
              File(_image!.path),
              width: widget.size,
              height: widget.size,
              fit: BoxFit.cover,
            ),
    );
  }
}
