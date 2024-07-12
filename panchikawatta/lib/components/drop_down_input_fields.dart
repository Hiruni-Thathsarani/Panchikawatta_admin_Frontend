  import 'package:flutter/material.dart';

class DropdownInputField extends StatefulWidget {
  final List<String> dropdownItems;
  final String hintText;
  final String? initialValue;
  final FormFieldValidator<String>? validator;

  DropdownInputField({
    required this.dropdownItems,
    required this.hintText,
    this.validator,
    this.initialValue, String? value,
  });

  @override
  _DropdownInputFieldState createState() => _DropdownInputFieldState();
}

class _DropdownInputFieldState extends State<DropdownInputField> {
  String? _dropdownValue;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: DropdownButtonFormField<String>(
          value: _dropdownValue,
          hint: Text(widget.hintText),
          items: widget.dropdownItems.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: DefaultTextStyle(
                style: const TextStyle(fontSize: 16, color: Color(0xCC000000), fontWeight: FontWeight.normal),
                child: Text(value),
              ),
            );
          }).toList(),
          validator: widget.validator,
          onChanged: (newValue) {
            setState(() {
              _dropdownValue = newValue;
            });
            _formKey.currentState!.validate();
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
