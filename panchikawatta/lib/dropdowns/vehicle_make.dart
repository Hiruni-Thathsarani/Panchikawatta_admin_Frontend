// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class VehicleMake extends StatefulWidget {
  final String? selectedMake;
  final Function(String?)? onChanged;

  const VehicleMake({super.key, this.selectedMake, this.onChanged});

  @override
  _VehicleMakeState createState() => _VehicleMakeState();
}

class _VehicleMakeState extends State<VehicleMake> {
  final List<String> _vehicleMakes = [
    'Any',
    'Toyota',
    'Honda',
    'Nissan',
    'Suzuki',
    'Hyundai',
    'Mitsubishi',
    'Mazda',
    'Kia',
    'BMW',
    'Mercedes-Benz',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedMake,
      hint: const Text('Make'),
      items: _vehicleMakes.map((String make) {
        return DropdownMenuItem<String>(
          value: make,
          child: Text(make),
        );
      }).toList(),
      onChanged: widget.onChanged,
      isExpanded: true,
    );
  }
}
