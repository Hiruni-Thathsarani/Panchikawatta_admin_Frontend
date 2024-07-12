// ignore_for_file: library_private_types_in_public_api, use_super_parameters
import 'package:flutter/material.dart';

class Fuel extends StatefulWidget {
  final String? selectedFuel;
  final void Function(String?) onChanged;

  const Fuel({
    Key? key,
    required this.selectedFuel,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ConditionState createState() => _ConditionState();
}

class _ConditionState extends State<Fuel> {
  final List<String> _fuelOptions = [
    'Any',
    'Petrol',
    'Diesel',
    'Electric',
    'Hybrid'
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedFuel,
      hint: const Text('Fuel'),
      items: _fuelOptions.map((String condition) {
        return DropdownMenuItem<String>(
          value: condition,
          child: Text(condition),
        );
      }).toList(),
      onChanged: widget.onChanged,
      isExpanded: true,
    );
  }
}
