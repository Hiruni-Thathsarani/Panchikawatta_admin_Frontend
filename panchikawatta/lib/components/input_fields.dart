// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';

class InputFields extends StatefulWidget {
  final String hintText;
  final double width1;
  final Icon? suffixIcon;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final VoidCallback? onPressed;
  final TextEditingController? controller;

  const InputFields({
    super.key,
    required this.hintText,
    required this.width1,
    this.suffixIcon,
    this.validator,
    this.focusNode,
    this.onPressed,
    this.controller,
  });

  @override
  _InputFieldsState createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  String _textFieldValue = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widget.width1,
      height: 55,
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            _textFieldValue = value;
          });
        },
        focusNode: widget.focusNode,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xCC000000),
              fontWeight: FontWeight.normal),
          filled: true,
          fillColor: const Color(0xFFFAFAFA),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
                  onPressed: widget.onPressed,
                  icon: widget.suffixIcon!,
                )
              : null,
        ),
        validator: widget.validator,
      ),
    );
  }
}
