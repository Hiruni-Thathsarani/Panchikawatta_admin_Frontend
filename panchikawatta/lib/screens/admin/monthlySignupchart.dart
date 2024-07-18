import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class AppColors {
  static const contentColor = Color(0xFFFF5C00);
  static const contentColor2 = Color.fromARGB(255, 20, 8, 122);
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

  bool showAvg = true;

  List<Map<String, dynamic>> monthlyData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
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
      color: Color.fromARGB(255, 5, 5, 5),
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.1,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18,
                left: 18,
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
                  fontSize: 18,
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
        text = '05';
        break;
      case 3:
        text = '10';
        break;
      case 5:
        text = '15';
        break;
      case 7:
        text = '20';

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
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white)),
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
              final int maxCount = monthlyData.isNotEmpty
                  ? monthlyData.map((data) => data['count']).reduce((a, b) => a > b ? a : b)
                  : 0;

              switch (value.toInt()) {
                case 1:
                  return Text('${(maxCount * 0.2).round()}',
                      style: const TextStyle(color: Colors.white));
                case 2:
                  return Text('${(maxCount * 0.4).round()}',
                      style: const TextStyle(color: Colors.white));
                case 3:
                  return Text('${(maxCount * 0.6).round()}',
                      style: const TextStyle(color: Colors.white));
                case 4:
                  return Text('${(maxCount * 0.8).round()}',
                      style: const TextStyle(color: Colors.white));
                case 5:
                  return Text('${(maxCount * 1).round()}',
                      style: const TextStyle(color: Colors.white));
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
      maxY: 5,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(monthlyData.length, (index) {
            final count = monthlyData[index]['count'].toDouble();
            return FlSpot(index.toDouble(), count / (monthlyData.map((data) => data['count']).reduce((a, b) => a > b ? a : b) / 5));
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
      lineTouchData: const LineTouchData(enabled: true),
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
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white)),
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
            getTitlesWidget: leftTitleWidgets,
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
        border: Border.all(
          color: Color.fromARGB(255, 55, 67, 77),
        ),
      ),
      minX: 0,
      maxX: monthlyData.length.toDouble() - 1,
      minY: 0,
      maxY: 5,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(monthlyData.length, (index) {
            final count = monthlyData[index]['count'].toDouble();
            return FlSpot(index.toDouble(), count / (monthlyData.map((data) => data['count']).reduce((a, b) => a > b ? a : b) / 5));
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
}
