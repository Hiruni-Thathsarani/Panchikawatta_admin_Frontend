// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';

class FuelDropdown extends StatefulWidget {
  final String? selectedFuel;
  final void Function(String?) onChanged;

  const FuelDropdown({
    Key? key,
    required this.selectedFuel,
    required this.onChanged,
  }) : super(key: key);

  @override
  _FuelDropdownState createState() => _FuelDropdownState();
}

class _FuelDropdownState extends State<FuelDropdown> {
  final List<String> _fuelOptions = [
    'Any',
    'Petrol',
    'Diesel',
    'Hybrid',
    'Electric'
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: _fuelOptions.map((fuel) {
        return ChoiceChip(
          label: Text(fuel),
          selected: widget.selectedFuel == fuel,
          selectedColor: const Color.fromARGB(255, 248, 159, 112),
          onSelected: (selected) {
            widget.onChanged(selected ? fuel : null);
          },
        );
      }).toList(),
    );
  }
}
