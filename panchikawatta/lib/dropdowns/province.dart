import 'package:flutter/material.dart';

class ProvinceDropdown extends StatelessWidget {
  final String? selectedProvince;
  final ValueChanged<String?> onChanged;

  final List<String> provinces = [
    'Central',
    'Eastern',
    'Northern',
    'Southern',
    'Western',
    'North Western',
    'North Central',
    'Uva',
    'Sabaragamuwa'
  ];

  ProvinceDropdown({super.key, this.selectedProvince, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedProvince,
      decoration: const InputDecoration(labelText: 'Province'),
      items: provinces.map((province) {
        return DropdownMenuItem<String>(
          value: province,
          child: Text(province),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
