import 'package:flutter/material.dart';

class OriginDropdown extends StatelessWidget {
  final String? selectedOrigin;
  final ValueChanged<String?> onChanged;

  OriginDropdown(
      {super.key, required this.selectedOrigin, required this.onChanged});

  final List<String> origins = [
    'Any',
    'Japan',
    'UK',
    'Germany',
    'USA',
    'India'
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedOrigin,
      decoration: const InputDecoration(labelText: 'Origin'),
      items: origins.map((origin) {
        return DropdownMenuItem<String>(
          value: origin,
          child: Text(origin),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
