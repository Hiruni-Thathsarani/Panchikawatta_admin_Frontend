import 'package:flutter/material.dart';
import 'package:panchikawatta/screens/admin/admin_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(Adsperday());
}

class Adsperday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily posted Ads',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List<Map<String, dynamic>> _tasks = [];

  Future<void> _fetchSpareParts(DateTime selectedDate) async {
    final response = await http.get(
      Uri.parse(
          'http://10.0.2.2:8000/admin/sparepartsBydate?selectedDate=$selectedDate'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _tasks = data.map((item) => item as Map<String, dynamic>).toList();
      });
    } else {
      throw Exception('Failed to load spare parts');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSpareParts(_selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF5C01), // Set custom color
        title: const Text('Daily posted Ads'),
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
            padding: const EdgeInsets.all(10.0),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 340,
                width: 300, // Adjust the height here
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) async {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    await _fetchSpareParts(selectedDay);
                  },
                  calendarFormat: _calendarFormat,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    markersMaxCount: 1,
                    markersAlignment: Alignment.bottomCenter,
                    markersOffset: const PositionedOffset(bottom: 8),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _tasks.isEmpty
                ? const Center(
                    child:
                        Text('No spare parts available for the selected date.'))
                : CarouselSlider(
                    options: CarouselOptions(
                      height: 500, // Increased height
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: const Duration(
                          milliseconds: 700), // Smoother transition
                      viewportFraction: 0.6, // Larger items
                    ),
                    items: _tasks.map((task) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    task['image'] ?? 'lib/assets/no_image.png',
                                    height: 50, // Increased image height
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    task['title'] ?? 'Unknown title',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Price: ${task['price'] ?? 'N/A'}',
                                    style: const TextStyle(
                                      color: Color(0xFFEB4B01),
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Year: ${task['year'] ?? 'N/A'}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Condition: ${task['condition'] ?? 'N/A'}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
