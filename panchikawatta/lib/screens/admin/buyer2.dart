import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:panchikawatta/screens/admin/admin_page.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<Map<String, dynamic>> contacts = [];
  List<Map<String, dynamic>> filteredContacts = [];
  TextEditingController searchController = TextEditingController();
  late OverlayEntry _popupDialog;

  @override
  void initState() {
    super.initState();
    fetchUsers();
    searchController.addListener(_filterContacts);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterContacts);
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/admin/user-details')); // Update the URL to match your backend

    if (response.statusCode == 200) {
      setState(() {
        contacts = List<Map<String, dynamic>>.from(json.decode(response.body));
        filteredContacts = contacts;
      });
    } else {
      // Handle the error
      print('Failed to load users');
    }
  }

  void _filterContacts() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredContacts = contacts.where((contact) {
        final name = contact['firstName']?.toLowerCase() + ' ' + contact['lastName']?.toLowerCase();
        final email = contact['email']!.toLowerCase();
        return name.contains(query) || email.contains(query);
      }).toList();
    });
  }

  void _showUserDetails(BuildContext context, Map<String, dynamic> contact) {
    _popupDialog = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          _popupDialog.remove();
        },
        child: Material(
          color: Colors.black54,
          child: Center(
            child: GestureDetector(
              onTap: () {}, // Prevents closing when tapping on the card itself
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(contact['imageUrl'] ?? 'https://via.placeholder.com/48'),
                          radius: 24,
                        ),
                        title: Text('${contact['firstName']} ${contact['lastName']}'),
                        subtitle: Text(contact['email']),
                      ),
                      const SizedBox(height: 16),
                      Text('ID: ${contact['id']}'),
                      const SizedBox(height: 8),
                      Text('Phone: ${contact['phoneNo']}'),
                      const SizedBox(height: 8),
                      Text('Province: ${contact['province'] ?? 'N/A'}'),
                      const SizedBox(height: 8),
                      Text('District: ${contact['district'] ?? 'N/A'}'),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            _popupDialog.remove();
                          },
                          child: const Text('Close'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_popupDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          backgroundColor: const Color(0xFFFF5C01), // Set custom color
          title: const Text('Buyers Details'),
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
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(contact['imageUrl'] ?? 'https://via.placeholder.com/48'),
                      radius: 24,
                    ),
                    title: Text('${contact['firstName']} ${contact['lastName']}'),
                    subtitle: Text(contact['email']),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        _showUserDetails(context, contact);
                      },
                    ),
                    onTap: () {
                      // Navigate to user details or perform any action on tap
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


