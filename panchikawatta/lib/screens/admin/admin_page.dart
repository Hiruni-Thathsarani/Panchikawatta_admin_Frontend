import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:panchikawatta/screens/admin/adsPerDay.dart';
import 'package:panchikawatta/screens/admin/buyer2.dart';
import 'package:panchikawatta/screens/admin/manage_accounts.dart';
import 'package:panchikawatta/screens/admin/sellerLocation.dart';
import 'package:panchikawatta/screens/admin/services.dart';
import 'package:panchikawatta/screens/admin/sparepartlist.dart';
import 'package:panchikawatta/screens/admin/vehiclelist.dart';
import 'package:panchikawatta/screens/admin/view_Analytics.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late Future<Map<String, dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
  }

  Future<Map<String, dynamic>> fetchData() async {
    try {
      var url = Uri.parse('http://10.0.2.2:8000/admin/details');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        int sparepartsCount = data['counts']['sparepartsCount'] ?? 0;
        int servicesCount = data['counts']['servicesCount'] ?? 0;

        return {
          'adminUsername': data['admin']['adminUsername'],
          'email': data['admin']['email'],
          'sellersCount': data['counts']['sellersCount'],
          'buyersCount': data['counts']['buyersCount'],
          'adsCount': sparepartsCount + servicesCount,
          'vehiclesCount': data['counts']['vehiclesCount'] ?? 0,
          'sparepartsCount': sparepartsCount,
          'servicesCount': servicesCount,
        };
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Portal')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!;
            return buildContent(data);
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard, color: Color(0xFFFF5C01)),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete, color: Color(0xFFFF5C01)),
            label: 'analyze',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Color(0xFFFF5C01)),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Color(0xFFFF5C01)),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget buildContent(Map<String, dynamic> data) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: Color(0xFFEBEBEB),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                // Handle profile picture upload action here
              },
              iconSize: 80,
              icon: const Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            data['adminUsername'],
            style: const TextStyle(fontSize: 13),
          ),
          Text(
            data['email'],
            style: const TextStyle(fontSize: 11),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return const ViewAnalyticApp();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFFF5C01),
                  minimumSize: const Size(150, 50),
                ),
                child: const Text('View Analytics'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return const ManageAccount();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFFF5C01),
                  minimumSize: const Size(150, 50),
                ),
                child: const Text('Manage Accounts'),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSquareButton(
                labelText: 'Sellers',
                count: data['sellersCount'],
                icon: Icons.person,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return DashboardScreen();
                  }));
                },
              ),
              _buildSquareButton(
                labelText: 'Buyers',
                count: data['buyersCount'],
                icon: Icons.shopping_cart,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return const UsersPage();
                  }));
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSquareButton(
                labelText: 'Ads',
                count: data['adsCount'],
                icon: Icons.library_books,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return Adsperday();
                  }));
                },
              ),
              _buildSquareButton(
                labelText: 'Vehicle',
                count: data['vehiclesCount'],
                icon: Icons.airport_shuttle_rounded,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return const VehicleDetail();
                  }));
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSquareButton(
                labelText: 'Spareparts',
                count: data['sparepartsCount'],
                icon: Icons.car_rental,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return SparePartsListPage();
                  }));
                },
              ),
              _buildSquareButton(
                labelText: 'Services',
                count: data['servicesCount'],
                icon: Icons.add_business,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return Services();
                  }));
                },
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildSquareButton({
    required String labelText,
    required int count,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    bool isHovered = false;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return MouseRegion(
          onEnter: (_) {
            setState(() {
              isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              isHovered = false;
            });
          },
          child: GestureDetector(
            onTap: onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isHovered ? 140 : 130, // Adjust button width here
              height: isHovered ? 110 : 100, // Adjust button height here
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isHovered
                    ? const Color(0xFFFFD700)
                    : const Color(0xFFEBEBEB),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon,
                          color: isHovered ? Colors.white : Colors.black),
                      const SizedBox(width: 5),
                      Text(
                        labelText,
                        style: TextStyle(
                          color: isHovered ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$count', // Display the count
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isHovered ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
