import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:panchikawatta/screens/admin/admin_page.dart';
import 'package:panchikawatta/screens/admin/services_page2.dart'; // Import the ServiceDetails page

class Services extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ServicesListPage(),
    );
  }
}

class ServicesListPage extends StatefulWidget {
  @override
  _ServicesListPageState createState() => _ServicesListPageState();
}

class _ServicesListPageState extends State<ServicesListPage> {
  late Future<List<Service>> futureServices;
  List<Service> services = [];
  List<Service> filteredServices = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureServices = fetchServices();
  }

  Future<List<Service>> fetchServices() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/admin/services-list'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        services = jsonResponse.map((service) => Service.fromJson(service)).toList();
        filteredServices = services;
      });
      return services;
    } else {
      throw Exception('Failed to load services');
    }
  }

  void filterServices(String query) {
    List<Service> filteredList = services
        .where((service) =>
            service.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredServices = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF5C01), // Set custom color
        title: const Text('Services'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return const AdminPage();
            }));
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Services',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                filterServices(value);
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Service>>(
              future: futureServices,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No services found'));
                } else {
                  return ListView.builder(
                    itemCount: filteredServices.length,
                    itemBuilder: (context, index) {
                      final service = filteredServices[index];
                      return ServiceCard(service: service);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Service {
  final int id;
  final String title;
  final String sellerId;
  final String description;
  final DateTime createdAt;

  Service({
    required this.id,
    required this.title,
    required this.sellerId,
    required this.description,
    required this.createdAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['serviceId'],
      title: json['title'],
      sellerId: 'Seller id: ${json['sellerId']}',
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final Service service;

  ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(service.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(service.sellerId),
            Text('Description: ${service.description}'),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ServiceDetails(serviceId: service.id),
          ));
        },
      ),
    );
  }
}
