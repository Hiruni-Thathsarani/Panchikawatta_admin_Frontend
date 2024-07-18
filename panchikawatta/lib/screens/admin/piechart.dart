// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pie_chart/pie_chart.dart' as pie_chart;

class PieChartWidget extends StatefulWidget {
  // ignore: use_super_parameters
  const PieChartWidget({Key? key}) : super(key: key);

  @override
  _PieChartWidgetState createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  late Future<Map<String, double>> _dataMapFuture;

  @override
  void initState() {
    super.initState();
    _dataMapFuture = fetchData();
  }

  Future<Map<String, double>> fetchData() async {
  print('Fetching data from backend...');
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/admin/fav-sparepart'));

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    print('Data fetched successfully.');
    List<dynamic> data = json.decode(response.body);
    Map<String, double> dataMap = {};

    for (var item in data) {
      dataMap[item['sparePartId'].toString()] = item['percentage'];
    }

    return dataMap;
  } else {
    print('Failed to fetch data.');
    throw Exception('Failed to load data');
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 202, 187, 187), // Set background color to black
      padding: const EdgeInsets.only(
        right: 18,
        left: 12,
        top: 70,
        bottom: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Most favorite Spare Parts',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 160, 155, 155), // Set text color to white
            ),
          ),
          const SizedBox(height: 100.0), // Space between the title and the pie chart
          FutureBuilder<Map<String, double>>(
            future: _dataMapFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return pie_chart.PieChart(
                  dataMap: snapshot.data!,
                  colorList: const [
                    Color(0xFFF26627), // Color 1
                    Color(0xFFF9A26C), // Color 2
                    Color(0xFFEFEEEE), // Color 3
                    Color(0xFF9BD7D1), // Color 4
                    Color(0xFF325D79), // Color 5
                  ],
                  chartRadius: MediaQuery.of(context).size.width / 1.5, // Adjusted size
                  ringStrokeWidth: 24,
                  animationDuration: const Duration(seconds: 2), // Animation duration
                  chartValuesOptions: const pie_chart.ChartValuesOptions(
                    showChartValues: true,
                    showChartValuesOutside: true,
                    showChartValuesInPercentage: true,
                    showChartValueBackground: false,
                    decimalPlaces: 1, // One decimal place for readability
                    chartValueStyle: TextStyle(
                      color: Colors.white, // Set chart values text color to white
                    ),
                  ),
                  legendOptions: const pie_chart.LegendOptions(
                    showLegends: true,
                    legendShape: BoxShape.rectangle,
                    legendTextStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white), // Set legend text color to white
                    legendPosition: pie_chart.LegendPosition.bottom, // Legend position
                    showLegendsInRow: true,
                  ),
                );
              } else {
                return const Text('No data available');
              }
            },
          ),
        ],
      ),
    );
  }
}
