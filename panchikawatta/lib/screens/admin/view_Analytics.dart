import 'package:flutter/material.dart';
import 'package:panchikawatta/screens/admin/barchart.dart';
import 'package:panchikawatta/screens/admin/monthly_visits.dart';
import 'package:panchikawatta/screens/admin/piechart.dart';
import 'package:panchikawatta/screens/admin/monthlySignupchart.dart';




class ViewAnalyticApp extends StatelessWidget {
  const ViewAnalyticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('View Analytics'),
          foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFFF5C01), // Custom color

          bottom: const TabBar(
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Popular Ads'),
              Tab(text: 'Monthly Signup'),
            ],
            labelColor: Colors.black,
            indicatorColor: Color(0xFFFF5C01),

          ),
        ),
        body: TabBarView(
          children: [
            PopularAds(),
            PieChartWidget(),
            const MonthlySignChart(),
          ],
        ),
      ),
    );
  }
}

class MonthlyVisitsContent extends StatelessWidget {
  const MonthlyVisitsContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Example counts, replace with your actual data or defaults
    int openedCount = 75;
    int engagedCount = 60;
    int eoiSentCount = 45;

    return Center(
      child: MonthlyVisitsWidget(
        openedCount: openedCount,
        engagedCount: engagedCount,
        eoiSentCount: eoiSentCount,
      ),
    );
  }
}
