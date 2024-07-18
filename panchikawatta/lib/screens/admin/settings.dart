import 'package:flutter/material.dart';
import 'package:panchikawatta/screens/admin/SplashScreen.dart';
import 'package:panchikawatta/screens/admin/admin_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return const AdminPage();
            }));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search button press
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.pink),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Handle Change Password tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.pink),
            title: const Text('Notification'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Handle Notification tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.security, color: Colors.pink),
            title: const Text('Privacy Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Handle Privacy Settings tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.pink),
            title: const Text('Sign Out'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Notification mute/unmute'),
            value: true,
            onChanged: (bool value) {
              // Handle switch change
            },
          ),
          ListTile(
            title: const Text('Languages'),
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('English'),
                Icon(Icons.chevron_right),
              ],
            ),
            onTap: () {
              // Handle Languages tap
            },
          ),
          ListTile(
            title: const Text('Linked Accounts'),
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Facebook, Google'),
                Icon(Icons.chevron_right),
              ],
            ),
            onTap: () {
              // Handle Linked Accounts tap
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return SplashScreen();
                  }));
              },
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    // Handle the logout action (e.g., clear user data, navigate to login screen)
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return const AdminPage(); // Replace with your login screen
    }));
  }
}
