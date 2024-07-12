// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  List<Map<String, dynamic>> vehicles = [];

  @override
  void initState() {
    super.initState();
    fetchVehicles();
  }

  Future<void> fetchVehicles() async {
    final response = await http
        // .get(Uri.parse('http://10.0.2.2:8000/users/getReminder/$vehicleId'));
        .get(Uri.parse('http://10.0.2.2:8000/users/getReminder'));
    if (response.statusCode == 200) {
      setState(() {
        vehicles = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load vehicles');
    }
  }

  Future<void> markAsDone(int vehicleId) async {
    final response = await http
        .delete(Uri.parse('http://localhost:5000/api/reminders/$vehicleId'));
    if (response.statusCode == 200) {
      fetchVehicles(); // Refresh the list after deletion
    } else {
      throw Exception('Failed to delete reminder');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Reminders',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 25,
            color: Color(0xFFFF5C01),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 1,
          mainAxisSpacing: 10,
        ),
        itemCount: vehicles.length,
        itemBuilder: (ctx, i) => VehicleItem(
          vehicleId: vehicles[i]['vehicleId'],
          make: vehicles[i]['make'],
          model: vehicles[i]['model'],
          year: vehicles[i]['year'].toString(),
          nearestReminder: vehicles[i]['nearestReminder']['type'] +
              ': ' +
              vehicles[i]['nearestReminder']['date'],
          onMarkAsDone: markAsDone,
        ),
      ),
    );
  }
}

class VehicleItem extends StatelessWidget {
  final int vehicleId;
  final String make;
  final String model;
  final String year;
  final String nearestReminder;
  final Function(int) onMarkAsDone;

  const VehicleItem({
    super.key,
    required this.vehicleId,
    required this.make,
    required this.model,
    required this.year,
    required this.nearestReminder,
    required this.onMarkAsDone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                const SizedBox(height: 20, width: 20),
                const Icon(Icons.car_crash_outlined,
                    size: 50, color: Color.fromARGB(255, 0, 0, 0)),
                const SizedBox(width: 50),
                Text('$make $model $year',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            Text('Reminder: $nearestReminder',
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 26, 10), fontSize: 16)),
            ElevatedButton(
              onPressed: () => onMarkAsDone(vehicleId),
              child: const Text('Mark as Done'),
            ),
          ],
        ),
      ),
    );
  }
}
