// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class VehicleModel extends StatefulWidget {
  final String? selectedModel;
  final List<String> models;
  final Function(String?)? onChanged;

  const VehicleModel(
      {super.key, this.selectedModel, required this.models, this.onChanged});

  @override
  _VehicleModelState createState() => _VehicleModelState();
}

class _VehicleModelState extends State<VehicleModel> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedModel,
      hint: const Text('Model'),
      items: widget.models.map((String model) {
        return DropdownMenuItem<String>(
          value: model,
          child: Text(model),
        );
      }).toList(),
      onChanged: widget.onChanged,
      isExpanded: true,
    );
  }
}

Map<String, List<String>> vehicleMakeToModels = {
  'Any': ['Any'],
  'Toyota': ['Corolla', 'Vitz', 'Prius', 'Hilux', 'Land Cruiser'],
  'Honda': ['Civic', 'Fit', 'Accord', 'CR-V', 'HR-V'],
  'Nissan': ['Leaf', 'Sunny', 'Juke', 'X-Trail', 'Navara'],
  'Suzuki': ['Alto', 'Swift', 'Wagon R', 'Baleno', 'Vitara'],
  'Hyundai': ['Elantra', 'Santa Fe', 'Tucson', 'i10', 'Sonata'],
  'Mitsubishi': ['Lancer', 'Outlander', 'Pajero', 'Mirage', 'Montero'],
  'Mazda': ['Demio', 'Axela', 'CX-5', 'Atenza', 'CX-3'],
  'Kia': ['Picanto', 'Sportage', 'Sorento', 'Rio', 'Cerato'],
  'BMW': ['3 Series', '5 Series', 'X1', 'X3', 'X5'],
  'Mercedes-Benz': ['C-Class', 'E-Class', 'A-Class', 'GLE', 'GLB'],
};
