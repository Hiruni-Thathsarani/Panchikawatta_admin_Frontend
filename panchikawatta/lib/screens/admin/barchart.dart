import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PopularAds extends StatelessWidget {
  final List<BarChartGroupData> barGroups = [
    BarChartGroupData(x: 9, barRods: [BarChartRodData(toY: 1500)]),
    BarChartGroupData(x: 10, barRods: [BarChartRodData(toY: 1700)]),
    BarChartGroupData(x: 11, barRods: [BarChartRodData(toY: 2000)]),
    BarChartGroupData(x: 12, barRods: [BarChartRodData(toY: 3890)]),
    BarChartGroupData(x: 13, barRods: [BarChartRodData(toY: 2500)]),
    BarChartGroupData(x: 14, barRods: [BarChartRodData(toY: 2700)]),
    BarChartGroupData(x: 15, barRods: [BarChartRodData(toY: 2600)]),
  ];

  PopularAds({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 248, 246, 246), // Set background color to black
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.black, // Set card color to black
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 2),
                const Text(
                  'Popular Ads',
                  style: TextStyle(
                    color: Colors.white, // Set text color to white
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 100, // Set the desired width
                    height: 1000, // Set the desired height
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 4000,
                        barTouchData: BarTouchData(enabled: true),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(
                                    color: Colors.white, // Set left title text color to white
                                  ),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                const style = TextStyle(
                                  color: Colors.white, // Set bottom title text color to white
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                );
                                Widget text;
                                switch (value.toInt()) {
                                  case 9:
                                    text = const Text('07/09', style: style);
                                    break;
                                  case 10:
                                    text = const Text('07/10', style: style);
                                    break;
                                  case 11:
                                    text = const Text('07/11', style: style);
                                    break;
                                  case 12:
                                    text = const Text('07/12', style: style);
                                    break;
                                  case 13:
                                    text = const Text('07/13', style: style);
                                    break;
                                  case 14:
                                    text = const Text('07/14', style: style);
                                    break;
                                  case 15:
                                    text = const Text('07/15', style: style);
                                    break;
                                  default:
                                    text = const Text('', style: style);
                                    break;
                                }
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: text,
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: barGroups,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
