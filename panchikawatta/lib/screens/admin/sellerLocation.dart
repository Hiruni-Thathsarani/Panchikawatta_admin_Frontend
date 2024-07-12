import 'package:flutter/material.dart';
import 'package:panchikawatta/screens/admin/admin_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SellerLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double southern = 0;
  double sabaragamuwaProvince = 0;
  double northern = 0;
  double central = 0;
  double uva = 0;
  double northWestern = 0;
  double western = 0;
  double eastern = 0;
  double northCentral = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/admin/sellers-provinces'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['provinces'];

      for (var entry in data) {
        switch (entry['province']) {
          case 'Southern':
            southern = entry['percentage'] != null ? double.parse(entry['percentage']) : 0;
            break;
          case 'Sabaragamuwa':
            sabaragamuwaProvince = entry['percentage'] != null ? double.parse(entry['percentage']) : 0;
            break;
          case 'Northern':
            northern = entry['percentage'] != null ? double.parse(entry['percentage']) : 0;
            break;
          case 'Central':
            central = entry['percentage'] != null ? double.parse(entry['percentage']) : 0;
            break;
          case 'Uva':
            uva = entry['percentage'] != null ? double.parse(entry['percentage']) : 0;
            break;
          case 'NorthWestern':
            northWestern = entry['percentage'] != null ? double.parse(entry['percentage']) : 0;
            break;
          case 'Western':
            western = entry['percentage'] != null ? double.parse(entry['percentage']) : 0;
            break;
          case 'Eastern':
            eastern = entry['percentage'] != null ? double.parse(entry['percentage']) : 0;
            break;
          case 'NorthCentral':
            northCentral = entry['percentage'] != null ? double.parse(entry['percentage']) : 0;
            break;
        }
      }

      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<ChartData> getChartData() {
    return [
      if (southern > 0) ChartData('Southern Province', southern, Colors.purple),
      if (sabaragamuwaProvince > 0) ChartData('Sabaragamuwa Province', sabaragamuwaProvince, Colors.green),
      if (northern > 0) ChartData('Northern', northern, const Color.fromARGB(255, 159, 30, 233)),
      if (central > 0) ChartData('Central', central, const Color.fromARGB(255, 30, 233, 101)),
      if (uva > 0) ChartData('Uva', uva, const Color.fromARGB(255, 50, 30, 233)),
      if (northWestern > 0) ChartData('North Western', northWestern, const Color.fromARGB(255, 233, 30, 125)),
      if (western > 0) ChartData('Western', western, Colors.blue),
      if (eastern > 0) ChartData('Eastern', eastern, Colors.orange),
      if (northCentral > 0) ChartData('North Central', northCentral, Colors.teal),
    ];
  }

  List<DataEntry> getDataEntries() {
    return [
      if (southern > 0) DataEntry(southern, 'Southern Province', Colors.purple),
      if (sabaragamuwaProvince > 0) DataEntry(sabaragamuwaProvince, 'Sabaragamuwa Province', Colors.green),
      if (northern > 0) DataEntry(northern, 'Northern', const Color.fromARGB(255, 159, 30, 233)),
      if (central > 0) DataEntry(central, 'Central', const Color.fromARGB(255, 30, 233, 101)),
      if (uva > 0) DataEntry(uva, 'Uva', const Color.fromARGB(255, 50, 30, 233)),
      if (northWestern > 0) DataEntry(northWestern, 'North Western', const Color.fromARGB(255, 233, 30, 125)),
      if (western > 0) DataEntry(western, 'Western', Colors.blue),
      if (eastern > 0) DataEntry(eastern, 'Eastern', Colors.orange),
      if (northCentral > 0) DataEntry(northCentral, 'North Central', Colors.teal),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return const AdminPage();
            }));
          },
        ),
        title: const Text(
          'Sellers',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications, color: Colors.black),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: const Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: SfCircularChart(
                      annotations: <CircularChartAnnotation>[
                        CircularChartAnnotation(
                          widget: Container(
                            child: Text(
                              '${(southern + sabaragamuwaProvince + northern + central + uva + northWestern + western + eastern + northCentral).toStringAsFixed(2)}%',
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                      series: <CircularSeries>[
                        DoughnutSeries<ChartData, String>(
                          dataSource: getChartData(),
                          pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          innerRadius: '75%',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: getDataEntries()
                          .map((entry) => ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: entry.color,
                                  radius: 10,
                                ),
                                title: Text(entry.address),
                                trailing: Text('${entry.percentage}%'),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}

class DataEntry {
  DataEntry(this.percentage, this.address, this.color);

  final double percentage;
  final String address;
  final Color color;
}
