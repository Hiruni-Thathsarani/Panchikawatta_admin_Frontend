// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ConditionDropdown extends StatefulWidget {
  final Set<String> selectedConditions;
  final ValueChanged<Set<String>> onChanged;

  const ConditionDropdown(
      {super.key, required this.selectedConditions, required this.onChanged});

  @override
  _ConditionDropdownState createState() => _ConditionDropdownState();
}

class _ConditionDropdownState extends State<ConditionDropdown> {
  final List<String> conditions = ['New', 'Used', 'Reconditioned'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: conditions.map((condition) {
        return ChoiceChip(
          label: Text(condition),
          selected: widget.selectedConditions.contains(condition),
          selectedColor: const Color.fromARGB(255, 248, 159, 112),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                widget.selectedConditions.add(condition);
              } else {
                widget.selectedConditions.remove(condition);
              }
              widget.onChanged(widget.selectedConditions);
            });
          },
        );
      }).toList(),
    );
  }
}
