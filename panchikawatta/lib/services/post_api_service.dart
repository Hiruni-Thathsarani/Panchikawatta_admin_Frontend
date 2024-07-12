// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:panchikawatta/constant/utils.dart';
import 'package:panchikawatta/models/service.dart';
import 'package:panchikawatta/models/sparepart.dart';

class PostApiService {
  Future<SparePart> postSparePart({
    required int sellerId,
    required String title,
    required String description,
    required int price,
    XFile? image,
    required String make,
    required String model,
    required String origin,
    required String condition,
    required String fuel,
    required int year,
  }) async {
    try {
      final url = Uri.parse('${Utils.baseUrl}/adPosting/postSparePart');
      final request = http.MultipartRequest('POST', url);

      request.fields['sellerId'] = sellerId.toString();
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['price'] = price.toString();
      request.fields['make'] = make;
      request.fields['model'] = model;
      request.fields['origin'] = origin;
      request.fields['condition'] = condition;
      request.fields['fuel'] = fuel;
      request.fields['year'] = year.toString();

      if (image != null) {
        final imageBytes = await image.readAsBytes();
        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            imageBytes,
            filename: image.name,
          ),
        );
      }

      final response = await http.Response.fromStream(await request.send());
      if (response.statusCode != 201) {
        throw Exception('Failed to post spare part');
      }

      final jsonResponse = jsonDecode(response.body);
      return SparePart.fromJson(jsonResponse);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  //Post Services
  Future<Service> postService({
    required int sellerId,
    required String title,
    required String description,
    XFile? image,
  }) async {
    try {
      final url = Uri.parse('${Utils.baseUrl}/adPosting/postService');
      final request = http.MultipartRequest('POST', url);

      // Set the fields
      request.fields['sellerId'] = sellerId.toString();
      request.fields['title'] = title;
      request.fields['description'] = description;

      // Print the fields for debugging
      print('Request fields: ${request.fields}');

      // Add the image if it exists
      if (image != null) {
        final imageBytes = await image.readAsBytes();
        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            imageBytes,
            filename: image.name,
          ),
        );
      }

      final response = await http.Response.fromStream(await request.send());
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return Service.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to post service: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
