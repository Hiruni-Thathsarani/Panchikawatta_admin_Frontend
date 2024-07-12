import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class AppColors {
  static const contentColor = Color(0xFFFF5C00);
  static const contentColor2 = Color.fromARGB(255, 27, 26, 26);
  static const mainGridLineColor = Color.fromARGB(217, 70, 70, 71);
}

class MonthlySignChart extends StatefulWidget {
  const MonthlySignChart({Key? key}) : super(key: key);

  @override
  State<MonthlySignChart> createState() => _MonthlySignChartState();
}

class _MonthlySignChartState extends State<MonthlySignChart> {
  List<Color> gradientColors = [
    const Color(0xFFFF5C00),
    AppColors.contentColor2,
  ];

  bool showAvg = false;

  List<Map<String, dynamic>> monthlyData = []; // List to hold monthly data

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when widget initializes
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('http://10.0.2.2:8000/admin/monthly-signups'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          monthlyData = responseData.cast<Map<String, dynamic>>();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 13, 14, 72),
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.1,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18,
                left: 12,
                top: 100,
                bottom: 12,
              ),
              child: LineChart(
                showAvg ? avgData() : mainData(),
              ),
            ),
          ),
          SizedBox(
            width: 50,
            height: 34,
            child: TextButton(
              onPressed: () {
                setState(() {
                  showAvg = !showAvg;
                });
              },
              child: Text(
                'avg',
                style: TextStyle(
                  fontSize: 17,
                  color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.white,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Colors.white,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) {
              if (monthlyData.isNotEmpty) {
                final index = value.toInt();
                if (index >= 0 && index < monthlyData.length) {
                  return Transform(
                    alignment: Alignment.center,
                    transform:
                        Matrix4.rotationZ(-1.5708), // Rotate by -90 degrees
                    child: Text(monthlyData[index]['month'],
                        style: const TextStyle(fontSize: 12, color: Colors.white)),
                  );
                }
              }
              return const Text('');
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              switch (value.toInt()) {
                case 1:
                  return const Text('10K', style: TextStyle(color: Colors.white));
                case 3:
                  return const Text('30k', style: TextStyle(color: Colors.white));
                case 5:
                  return const Text('50k', style: TextStyle(color: Colors.white));
                default:
                  return const Text('');
              }
            },
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: monthlyData.length.toDouble() - 1,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(monthlyData.length, (index) {
            final count = monthlyData[index]['count'].toDouble();
            return FlSpot(index.toDouble(), count);
          }),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              if (monthlyData.isNotEmpty) {
                final index = value.toInt();
                if (index >= 0 && index < monthlyData.length) {
                  return Transform(
                    alignment: Alignment.center,
                    transform:
                        Matrix4.rotationZ(-1.5708), // Rotate by -90 degrees
                    child: Text(monthlyData[index]['month'],
                        style: const TextStyle(fontSize: 12, color: Colors.white)),
                  );
                }
              }
              return const Text('');
            },
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              switch (value.toInt()) {
                case 1:
                  return const Text('10K', style: TextStyle(color: Colors.white));
                case 3:
                  return const Text('30k', style: TextStyle(color: Colors.white));
                case 5:
                  return const Text('50k', style: TextStyle(color: Colors.white));
                default:
                  return const Text('');
              }
            },
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: monthlyData.length.toDouble() - 1,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(monthlyData.length, (index) {
            return FlSpot(index.toDouble(),
                3.44); // Adjust this to actual data if available
          }),
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.5)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
