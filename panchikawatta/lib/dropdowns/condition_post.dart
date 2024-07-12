// ignore_for_file: library_private_types_in_public_api, use_super_parameters
import 'package:flutter/material.dart';

class Condition extends StatefulWidget {
  final String? selectedCondition;
  final void Function(String?) onChanged;

  const Condition({
    Key? key,
    required this.selectedCondition,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ConditionState createState() => _ConditionState();
}

class _ConditionState extends State<Condition> {
  final List<String> _conditionOptions = [
    'New',
    'Used',
    'Reconditioned',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedCondition,
      hint: const Text('Condition'),
      items: _conditionOptions.map((String condition) {
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
