import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SparePartDetails extends StatelessWidget {
  final int sparePartId;

  SparePartDetails({required this.sparePartId});

  Future<Map<String, dynamic>> fetchSparePartDetails() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/admin/spareparts-details/$sparePartId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load spare part details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF5C01), // Custom color
        title: const Text('Spare Part Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchSparePartDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No details found'));
          } else {
            var sparePart = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sparePart['title'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text('Description', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    sparePart['description'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text('Price', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    '\$${sparePart['price']}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: const Icon(Icons.calendar_today),
                          title: Text('Created At: ${sparePart['createdAt']}'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Business Name', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    sparePart['businessName'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text('Business Address',
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    sparePart['businessAddress'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
