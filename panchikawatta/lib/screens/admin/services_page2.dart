import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'services.dart'; // Import the Service class

class ServiceDetails extends StatelessWidget {
  final int serviceId;

  ServiceDetails({required this.serviceId});

  Future<Map<String, dynamic>> fetchServiceDetails() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/admin/service-details/$serviceId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load service details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchServiceDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
          backgroundColor: const Color(0xFFFF5C01), // Set custom color
          title: const Text('Services'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return  Services();
                }));
                        },
          ),
        ),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Service Details'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          Map<String, dynamic> data = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(data['title']),
              backgroundColor: const Color(0xFFFF5C01),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: ServicedetailsPage(
              service: Service(
                title: data['title'],
                description: data['description'],
                createdAt: DateTime.parse(data['createdAt']),
//imageUrl: '', // Add your image URL if available
                sellerId: '',
                 id: serviceId, // Ensure you have the sellerId if needed
              ),
              businessName: data['businessName'],
              serviceCenterLocation: data['businessAddress'],
            ),
          );
        }
      },
    );
  }
}

class ServicedetailsPage extends StatelessWidget {
  final Service service;
  final String businessName;
  final String serviceCenterLocation;

  ServicedetailsPage({
    required this.service,
    required this.businessName,
    required this.serviceCenterLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
              //  Image.network(service.imageUrl, height: 150),
                const SizedBox(height: 8),
                Text(
                  service.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(service.sellerId), // Replace with actual seller info if needed
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: Text('Date: ${service.createdAt.toLocal().toString().split(' ')[0]}'),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: const Icon(Icons.access_time),
                  title: Text('Time: ${service.createdAt.toLocal().toString().split(' ')[1].split('.')[0]}'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Business Name', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Text(
            businessName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('Service Center Location', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Text(
            serviceCenterLocation,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('Description', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Text(
            service.description,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
