import 'package:flutter/material.dart';

class DistrictDropdown extends StatelessWidget {
  final String? selectedDistrict;
  final String? selectedProvince;
  final ValueChanged<String?> onChanged;

  final Map<String, List<String>> provinceToDistricts = {
    'Central': ['Kandy', 'Matale', 'Nuwara Eliya'],
    'Eastern': ['Ampara', 'Batticaloa', 'Trincomalee'],
    'Northern': ['Jaffna', 'Kilinochchi', 'Mannar', 'Mullaitivu', 'Vavuniya'],
    'Southern': ['Galle', 'Matara', 'Hambantota'],
    'Western': ['Colombo', 'Gampaha', 'Kalutara'],
    'North Western': ['Kurunegala', 'Puttalam'],
    'North Central': ['Anuradhapura', 'Polonnaruwa'],
    'Uva': ['Badulla', 'Monaragala'],
    'Sabaragamuwa': ['Ratnapura', 'Kegalle'],
  };

  DistrictDropdown(
      {super.key,
      this.selectedDistrict,
      this.selectedProvince,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    List<String> districts = selectedProvince != null &&
            provinceToDistricts.containsKey(selectedProvince)
        ? provinceToDistricts[selectedProvince]!
        : [];

    return DropdownButtonFormField<String>(
      value: selectedDistrict,
      decoration: const InputDecoration(labelText: 'District'),
      items: districts.map((district) {
        return DropdownMenuItem<String>(
          value: district,
          child: Text(district),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
