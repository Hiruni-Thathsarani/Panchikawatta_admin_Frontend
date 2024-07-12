// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:panchikawatta/constant/utils.dart';
import 'package:panchikawatta/models/sparepart.dart';

class GetApiService {
  Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse('${Utils.baseUrl}/users'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<SparePart>> getSpareParts() async {
    final response =
        await http.get(Uri.parse('${Utils.baseUrl}/adListing/getSpareParts'));

    if (response.statusCode == 200) {
      final List<dynamic> sparePartsJson = json.decode(response.body);
      return sparePartsJson.map((json) => SparePart.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load spareparts');
    }
  }

  Future<SparePart> getSparePartById(int sparePartId) async {
    final response = await http
        .get(Uri.parse('${Utils.baseUrl}/users/spare-parts/$sparePartId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final SparePart sparePart =
          SparePart.fromJson(jsonResponse); // Directly map to SparePart
      print(sparePart);
      return sparePart;
    } else {
      throw Exception('Failed to load spare part');
    }
  }

  Future<List<SparePart>> searchSpareparts(String keyword) async {
    final response = await http
        .get(Uri.parse('${Utils.baseUrl}/adListing/search?keyword=$keyword'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => SparePart.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load spare parts');
    }
  }

  Future<List<SparePart>> fetchFilteredAds({
    String? province,
    String? district,
    String? vehicleMake,
    String? model,
    String? origin,
    String? minPrice,
    String? maxPrice,
    List<String>? conditions,
    List<String>? fuelTypes,
    String? minYear,
    String? maxYear,
  }) async {
    final queryParameters = {
      'province': province,
      'district': district,
      'vehicleMake': vehicleMake,
      'model': model,
      'origin': origin,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'conditions': conditions?.join(','),
      'fuelTypes': fuelTypes?.join(','),
      'minYear': minYear,
      'maxYear': maxYear,
    };

    final uri = Uri.http(
      Utils.baseUrl,
      '/adListing/filter',
      queryParameters
        ..removeWhere((key, value) => value == null || value.isEmpty),
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => SparePart.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load spare parts');
    }
  }
}
