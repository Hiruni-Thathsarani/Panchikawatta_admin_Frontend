import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class MonthlyVisitsWidget extends StatelessWidget {
  final int openedCount;
  final int engagedCount;
  final int eoiSentCount;

  const MonthlyVisitsWidget({super.key, 
    required this.openedCount,
    required this.engagedCount,
    required this.eoiSentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            'Monthly Visits Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: openedCount / 100.0,
                  backgroundColor: Colors.orange.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF5C00)),
                  strokeWidth: 7,
                ),
              ),
              SizedBox(
                width: 180,
                height: 180,
                child: CircularProgressIndicator(
                  value: engagedCount / 100.0,
                  backgroundColor: const Color(0xFF9BD7D1).withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF9BD7D1)),
                  strokeWidth: 7,
                ),
              ),
              SizedBox(
                width: 160,
                height: 160,
                child: CircularProgressIndicator(
                  value: eoiSentCount / 100.0,
                  backgroundColor: const Color(0xFF325D79).withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF325D79)),
                  strokeWidth: 7,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total Visits',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${openedCount + engagedCount + eoiSentCount}',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProgressIndicator('Opened', openedCount, const Color(0xFFFF5C00)),
              _buildProgressIndicator(
                  'Engaged', engagedCount, const Color(0xFF325D79)),
              _buildProgressIndicator(
                  'EOI Sent', eoiSentCount, const Color(0xFF9BD7D1)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(String label, int count, Color color) {
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 40,
          child: FAProgressBar(
            currentValue: count.toDouble(), // Convert int to double
            size: 10,
            maxValue: 100.0, // Ensure maxValue is double
            backgroundColor: color.withOpacity(0.3),
            progressColor: color,
            animatedDuration: const Duration(seconds: 1),
            direction: Axis.vertical,
            verticalDirection: VerticalDirection.up,
          ),
        ),
        const SizedBox(height: 5),
        Text('$label\n$count%', textAlign: TextAlign.center),
      ],
    );
  }
}
