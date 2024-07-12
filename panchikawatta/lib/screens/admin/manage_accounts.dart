import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:panchikawatta/screens/admin/admin_page.dart';
import 'dart:convert';
import 'User.dart'; // Import the User class
import 'user_details_page.dart'; // Import the UserDetailsPage

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

  Future<void> deleteUser(User user) async {
    final response = await http.delete(Uri.parse('http://10.0.2.2:8000/admin/user-delete/${user.id}')); // Use user ID in the URL

    if (response.statusCode == 200) {
      setState(() {
        users.remove(user);
        filteredUsers.remove(user); // Remove from filtered list as well
      });
    } else {
      // Handle the error
      print('Failed to delete user');
    }
  }

  void showDeleteConfirmationDialog(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete this user account?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                deleteUser(user);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Yes, Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          backgroundColor: const Color(0xFFFF5C01), // Set custom color
          title: const Text('User Management'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return  const AdminPage();
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
                    backgroundImage: AssetImage('assets/profile_${index + 1}.jpg'), // Replace with actual image path
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(user.activity),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Color(0xFFFF5C00)),
                        onPressed: () {
                          showDeleteConfirmationDialog(user);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return UserDetailsPage(user: user);
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
