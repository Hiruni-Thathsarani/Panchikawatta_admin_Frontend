import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:panchikawatta/screens/admin/manage_accounts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserDetailsScreen(email: 'user@example.com'), // Replace with actual email
    );
  }
}

class UserDetailsScreen extends StatefulWidget {
  final String email;

  UserDetailsScreen({required this.email});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late Future<Map<String, dynamic>> userData;

  // Frontend variables
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNo = '';
  String businessName = '';
  String businessPhoneNo = '';
  String businessDescription = '';
  String imageUrl = '';

  final String defaultImageUrl =
      'https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/no-profile-picture-icon.png';

  Future<Map<String, dynamic>> fetchUserData(String email) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/admin/users/email/$email'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  void initState() {
    super.initState();
    userData = fetchUserData(widget.email).then((data) {
      setState(() {
        firstName = data['firstName'];
        lastName = data['lastName'];
        email = data['email'];
        phoneNo = data['phoneNo'];
        imageUrl = data['imageUrls'][0] ?? defaultImageUrl;

        // Check if seller details are present
        if (data['seller'] != null) {
          businessName = data['seller']['businessName'];
          businessPhoneNo = data['seller']['businessPhoneNo'];
          businessDescription = data['seller']['businessDescription'];
        } else {
          businessName = '';
          businessPhoneNo = '';
          businessDescription = '';
        }
      });
      return data;
    });
  }

  Future<void> deleteUser() async {
    // Show confirmation dialog
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User clicked the cancel button
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User clicked the confirm button
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/admin/users/email/${widget.email}'),
      );
      print(widget.email);

      if (response.statusCode == 200) {
        // Navigate back to ManageAccount page after successful deletion
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return const ManageAccount();
        }));
      } else {
        throw Exception('Failed to delete user');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return const ManageAccount();
            }));
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data found'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: NetworkImage(imageUrl.isEmpty ? defaultImageUrl : imageUrl),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: '$firstName $lastName',
                    ),
                    enabled: true, // Make it read-only
                    controller: TextEditingController(text: '$firstName $lastName'),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: email,
                    ),
                    enabled: true, // Make it read-only
                    controller: TextEditingController(text: email),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Contact',
                      hintText: phoneNo,
                    ),
                    enabled: true, // Make it read-only
                    controller: TextEditingController(text: phoneNo),
                  ),
                  const SizedBox(height: 20),
                  const Text('Seller Details', style: TextStyle(fontWeight: FontWeight.bold)),
                  if (businessName.isNotEmpty) ...[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Business Name',
                        hintText: businessName,
                      ),
                      enabled: true, // Make it read-only
                      controller: TextEditingController(text: businessName),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Business Contact No',
                        hintText: businessPhoneNo,
                      ),
                      enabled: true, // Make it read-only
                      controller: TextEditingController(text: businessPhoneNo),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Business Description',
                        hintText: businessDescription,
                      ),
                      enabled: true, // Make it read-only
                      controller: TextEditingController(text: businessDescription),
                    ),
                  ],
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: deleteUser,
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
