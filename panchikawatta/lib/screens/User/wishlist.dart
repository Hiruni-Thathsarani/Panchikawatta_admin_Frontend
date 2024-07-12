// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final TextEditingController searchController = TextEditingController();
  List<WishlistItem> wishlistItems = [
    WishlistItem(
        imageUrl: 'assets/images/OIP.jpg', title: 'Item 1', price: 100),
    WishlistItem(
        imageUrl: 'assets/images/OIP.jpg', title: 'Item 2', price: 200),
    WishlistItem(
        imageUrl: 'assets/images/OIP.jpg', title: 'Item 3', price: 300),
    WishlistItem(
        imageUrl: 'assets/images/OIP.jpg', title: 'Item 4', price: 400),
  ];
  List<WishlistItem> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = wishlistItems;
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredItems = wishlistItems;
      } else {
        filteredItems = wishlistItems
            .where((item) =>
                item.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: _filterItems,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Image.network(
                            item.imageUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\$${item.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
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

class WishlistItem {
  final String imageUrl;
  final String title;
  final double price;

  WishlistItem({
    required this.imageUrl,
    required this.title,
    required this.price,
  });
}
