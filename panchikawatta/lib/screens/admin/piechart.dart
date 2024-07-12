import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart' as pie_chart;

class PieChartWidget extends StatelessWidget {
  // Data for the pie chart
  final Map<String, double> dataMap = {
    "Ad 1": 18.47,
    "Ad 2": 17.70,
    "Ad 3": 4.25,
    "Ad 4": 3.51,
    "Ad 5": 2.83,
  };

  // Updated colors for each segment to match a bright theme
  final List<Color> colorList = [
    const Color(0xFFF26627), // Color 1
    const Color(0xFFF9A26C), // Color 2
    const Color(0xFFEFEEEE), // Color 3
    const Color(0xFF9BD7D1), // Color 4
    const Color(0xFF325D79), // Color 5
  ];

  PieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Set background color to black
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
            'Most Viewed Ads',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 160, 155, 155), // Set text color to white
            ),
          ),
          const SizedBox(
              height: 100.0), // Space between the title and the pie chart
          pie_chart.PieChart(
            dataMap: dataMap,
            colorList: colorList,
            chartRadius:
                MediaQuery.of(context).size.width / 1.5, // Adjusted size
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
          ),
        ],
      ),
    );
  }
}
