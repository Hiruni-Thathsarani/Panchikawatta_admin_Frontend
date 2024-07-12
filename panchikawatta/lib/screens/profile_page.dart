import 'package:flutter/material.dart';
import 'package:panchikawatta/screens/Profile/buyer_profile.dart';
import 'package:panchikawatta/screens/delete_and_edit_my_profile.dart';
import 'package:panchikawatta/screens/Profile/edit_profile_page.dart';
import 'package:panchikawatta/screens/seller_profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
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
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () {
            // Navigate to the previous page
            Navigator.pop(context);
          },
        ),
        title: const Text('My Profile',
            style: TextStyle(color: Color(0xFFFF5C01), fontSize: 28)),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings, color: Colors.black, size: 28),
            onSelected: (String result) {
              switch (result) {
                case 'EditProfile':
                  // Handle action for EditProfile
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                  break;
                case 'DeleteProfile':
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteProfileDialog();
                    },
                  );

                  break;
                case 'Logout':
                  // Handle your action for Logout
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Logout();
                    },
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'EditProfile',
                child: Text('Edit Profile'),
              ),
              const PopupMenuItem<String>(
                value: 'DeleteProfile',
                child: Text('Delete Profile'),
              ),
              const PopupMenuItem<String>(
                value: 'Logout',
                child:
                    Text('Logout', style: TextStyle(color: Color(0xFFFF5C01))),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                  'lib/assets/profilePicture.jpg',
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Center(
                child: Text(
              'Anne_Fernando82',
              style: TextStyle(
                fontSize: 18,
              ),
            )),

            const SizedBox(height: 25),

            TabBar(
              controller: _tabController,
              tabs: [
                _individualTab(
                  'Buyer',
                ),
                _individualTab('Seller'),
              ],
              labelColor: const Color(0xFFFF5C01),
              unselectedLabelColor: const Color(0x80000000),
              indicatorColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: const EdgeInsets.all(0),
              indicatorPadding: const EdgeInsets.all(0),
              dividerColor: Colors.transparent,
            ),

            // Container(
            //   height: 2000, // You can adjust this value as needed
            //   child: TabBarView(
            //     controller: _tabController,
            //     children: [
            //       Expanded(
            //         child: BuyerProfile(),
            //       ),
            //       SellerProfile(),],
            //   ),
            // ),

            Container(
              height: 2000, // You can adjust this value as needed
              child: TabBarView(
                controller: _tabController,
                children: [
                  BuyerProfile(),
                  SellerProfile(),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  //A method to create an individual tab. This is created to add a vertical divider between the tabs.
  Widget _individualTab(String text) {
    return Container(
      height: 50 + MediaQuery.of(context).padding.bottom,
      padding: const EdgeInsets.all(0),
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(
              right: BorderSide(
                  color: Color(0x80000000),
                  width: 0,
                  style: BorderStyle.solid))),
      child: Tab(
        text: text,
      ),
    );
  }
}
