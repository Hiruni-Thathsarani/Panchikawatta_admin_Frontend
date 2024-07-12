import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VehicleListPage extends StatefulWidget {
  final String userId;

  VehicleListPage({Key? key, required this.userId}) : super(key: key);

  @override
  VehicleListPageState createState() => VehicleListPageState();
}

class VehicleListPageState extends State<VehicleListPage> {
  List<dynamic> vehicles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVehicles();
  }

  Future<void> fetchVehicles() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/admin/user-vehicle/${widget.userId}'),
      );

      if (response.statusCode == 200) {
        setState(() {
          vehicles = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        // Handle errors
        print('Failed to load vehicles');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Exception while fetching data: $e');
    }
  }

  double getImageHeight(String type) {
    switch (type) {
      case 'Car':
        return 200.0; // Adjust size for Car
      case 'Lorry':
        return 180.0; // Adjust size for Lorry
      case 'Motorcycle':
        return 150.0; // Adjust size for Motorcycle
      case 'Threewheel':
        return 130.0; // Adjust size for Threewheel
      case 'Van':
        return 170.0; // Adjust size for Van
      default:
        return 200.0; // Default size
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.867),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User ${widget.userId}',
                style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];

                // Ensure vehicle['make'], vehicle['model'], etc. are not null before using
                final make = vehicle['make'] ?? 'Unknown Make';
                final model = vehicle['model'] ?? 'Unknown Model';
                final year = vehicle['year'] ?? 'Unknown Year';
                final type = vehicle['type'] ?? 'Unknown Type';
                var imageUrl = vehicle['imageUrl'] ??
                    'https://via.placeholder.com/900'; // Default placeholder URL

                // Replace with actual URLs based on vehicle type
                if (type == 'Car') {
                  imageUrl = 'https://img.freepik.com/free-vector/white-sedan-car-isolated-white-vector_53876-67413.jpg?w=900&t=st=1719593369~exp=1719593969~hmac=4658048734bd24e1daacea3b83fe11711f7eaa221f30690dcb224af4be3c53b8';
                } else if (type == 'Lorry') {
                  imageUrl = 'https://www.shutterstock.com/shutterstock/photos/2406473249/display_1500/stock-vector-red-truck-art-semi-truck-american-trailer-haul-design-template-powerful-engine-lorry-art-cartoon-2406473249.jpg';
                } else if (type == 'Motorcycle') {
                  imageUrl = 'https://img.freepik.com/free-photo/black-motorcycle-white_1398-276.jpg?t=st=1719593653~exp=1719597253~hmac=b1f0976d1bfa3f982a12922772344b327669243382c369aa7bfd7bf57f403939&w=996';
                } else if (type == 'Threewheel') {
                  imageUrl = 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.justdial.com%2Fjdmart%2FErnakulam%2FBajaj-Auto-Rickshaw-Efficient-Three-Wheeler%2Fpid-2020285976%2F0484PX484-X484-210416112425-S6Q7&psig=AOvVaw20OTp6wgS-MKgnx4JZALmV&ust=1719806979224000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCKjmjLG6gocDFQAAAAAdAAAAABAj';
                } else if (type == 'Van') {
                  imageUrl = 'https://img.freepik.com/premium-photo/3d-render-van_161488-118.jpg?w=1060';
                }

                final imageHeight = getImageHeight(type);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: const Color.fromARGB(255, 142, 137, 137),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                            imageUrl,
                            height: imageHeight, // Adjust the height based on vehicle type
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        'https://via.placeholder.com/24', // Replace with actual logo URL
                                        width: 24,
                                        height: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '$make - $model',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '$year year',
                                        style: const TextStyle(
                                            color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Text(
                                    type,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: VehicleListPage(userId: '1'), // Replace '1' with actual userId
  ));
}
