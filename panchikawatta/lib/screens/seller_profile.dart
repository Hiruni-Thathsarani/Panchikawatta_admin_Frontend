import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:panchikawatta/components/custom_button.dart';
import 'package:panchikawatta/screens/AdPost/adType.dart';
import 'package:panchikawatta/screens/services_ads.dart';
import 'package:panchikawatta/screens/spare_parts_ads.dart';

class SellerProfile extends StatefulWidget {
  @override
  _SellerProfile createState() => _SellerProfile();
}

class _SellerProfile extends State<SellerProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.pink.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            //Text('data')

            Center(
              child: CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdType()),
                    );
                  },
                  text: 'Post ad'),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Divider(
                color: Color(0x80000000),
                thickness: 1,
              ),
            ),

            const SizedBox(height: 20),

            Padding(
                padding: const EdgeInsets.only(left: 30, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('My Ads',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                    const SizedBox(width: 40),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0x80FF5C01),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          tabs: const [
                            Tab(text: 'Spare Parts'),
                            Tab(text: 'Services'),
                          ],
                          dividerColor: Colors.transparent,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFFFF55C01),
                          ),
                          indicatorColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                        ),
                      ),
                    ),
                  ],
                )),

            const SizedBox(height: 20),

            Container(
              height: 2000, // You can adjust this value as needed
              child: TabBarView(
                controller: _tabController,
                children: [
                  SparePartsAds(),
                  ServicesAds(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
