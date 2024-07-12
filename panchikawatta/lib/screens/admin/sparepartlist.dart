import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:panchikawatta/screens/admin/admin_page.dart';
import 'package:panchikawatta/screens/admin/sparepart_details_page.dart';

class SpareParts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SparePartsListPage(),
    );
  }
}

class SparePartsListPage extends StatefulWidget {
  @override
  _SparePartsListPageState createState() => _SparePartsListPageState();
}

class _SparePartsListPageState extends State<SparePartsListPage> {
  late Future<List<SparePart>> futureSpareParts;
  List<SparePart> spareParts = [];
  List<SparePart> filteredSpareParts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureSpareParts = fetchSpareParts();
  }

  Future<List<SparePart>> fetchSpareParts() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/admin/sparepart-list'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        spareParts = jsonResponse
            .map((sparePart) => SparePart.fromJson(sparePart))
            .toList();
        filteredSpareParts = spareParts;
      });
      return spareParts;
    } else {
      throw Exception('Failed to load spare parts');
    }
  }

  void filterSpareParts(String query) {
    List<SparePart> filteredList = spareParts
        .where((sparePart) =>
            sparePart.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredSpareParts = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF5C01), // Set custom color
        title: const Text('Spareparts'),
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
              decoration: const InputDecoration(
                labelText: 'Search Spare Parts',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                filterSpareParts(value);
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<SparePart>>(
              future: futureSpareParts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No spare parts found'));
                } else {
                  return ListView.builder(
                    itemCount: filteredSpareParts.length,
                    itemBuilder: (context, index) {
                      final sparePart = filteredSpareParts[index];
                      return SparePartCard(sparePart: sparePart);
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

class SparePart {
  final int id;
  final String title;
  final String sellerId;
  final String description;
  final DateTime createdAt;

  SparePart({
    required this.id,
    required this.title,
    required this.sellerId,
    required this.description,
    required this.createdAt,
  });

  factory SparePart.fromJson(Map<String, dynamic> json) {
    return SparePart(
      id: json['sparePartId'],
      title: json['title'],
      sellerId: 'Seller id: ${json['sellerId']}',
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class SparePartCard extends StatelessWidget {
  final SparePart sparePart;

  SparePartCard({required this.sparePart});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(sparePart.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sparePart.sellerId),
            Text('Description: ${sparePart.description}'),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => SparePartDetails(sparePartId: sparePart.id),
          ));
        },
      ),
    );
  }
}
