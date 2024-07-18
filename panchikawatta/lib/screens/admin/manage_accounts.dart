import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'User.dart'; // Import the User class
import 'user_details_page.dart'; // Import the UserDetailsScreen
import 'package:panchikawatta/screens/admin/admin_page.dart';

class ManageAccount extends StatefulWidget {
  const ManageAccount({Key? key}) : super(key: key);

  @override
  State<ManageAccount> createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {
  List<User> users = []; // List of users
  List<User> filteredUsers = []; // List of filtered users
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUsers(); // Fetch users data
    searchController.addListener(() {
      filterUsers(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/admin/user-details')); // Update the URL to match your backend

    if (response.statusCode == 200) {
      setState(() {
        users = List<User>.from(json.decode(response.body).map((data) => User.fromJson(data)));
        filteredUsers = List<User>.from(users); // Initialize filtered users with a copy of the full user list
      });
      printAllUserImages();
    } else {
      // Handle the error
      print('Failed to load users');
    }
  }

  void filterUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredUsers = List<User>.from(users); // Reset to original user list
      } else {
        filteredUsers = users.where((user) => user.name.toLowerCase().contains(query.toLowerCase())).toList();
      }
    });
  }

  void printAllUserImages() {
    for (var user in users) {
      print('User: ${user.name}, Image URL: ${user.imageUrls}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF5C01),
        title: const Text('User Management'),
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
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search Users',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: user.imageUrls != null && user.imageUrls!.isNotEmpty
                        ? NetworkImage(user.imageUrls!)
                        : const NetworkImage('https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/no-profile-picture-icon.png'),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Text(user.activity),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return UserDetailsScreen(email: user.email);
                    }));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
