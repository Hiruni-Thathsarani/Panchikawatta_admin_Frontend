import 'package:flutter/material.dart';
import 'package:panchikawatta/screens/User/buy_screen.dart';
import 'package:panchikawatta/screens/User/filter_sort.dart';
import 'package:panchikawatta/services/get_api_services.dart';
import 'package:panchikawatta/models/sparepart.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required ads});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<SparePart>> _spareParts;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _spareParts = GetApiService().searchSpareparts('');
  }

  void _search() {
    setState(() {
      _spareParts = GetApiService().searchSpareparts(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        actions: const [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Buyer',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Color(0xffFF5C01)),
                  ),
                  Text(
                    'Anne_fernando82',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(width: 5),
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/images/profile_image.png'),
              ),
            ],
          ),
          SizedBox(width: 5),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xffFF5C01),
                  size: 30,
                ),
                filled: true,
                fillColor: const Color(0xffFAFAFA),
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
                hintText: "Search",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Color(0xffFAFAFA)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Color(0xffFAFAFA)),
                ),
              ),
              onFieldSubmitted: (value) {
                _search();
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'newest',
                      child: Text('Newest first'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'best_match',
                      child: Text('Best match'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'price_low_high',
                      child: Text('Price: Low to High'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'price_high_low',
                      child: Text('Price: High to Low'),
                    ),
                  ],
                  onSelected: (String value) {
                    // Handle sorting logic here
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.sort_rounded,
                        color: Color(0xffFF5C01),
                        size: 25,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Sort by',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffFF5C01),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FilterSortScreen(),
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                        'Filter results',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffFF5C01),
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.grid_view_outlined,
                        color: Color(0xffFF5C01),
                        size: 23,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<SparePart>>(
                future: _spareParts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No SpareParts found'));
                  } else {
                    return GridView.builder(
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, i) {
                        var sparePart = snapshot.data![i];
                        final imageUrl = sparePart.imageUrl.isNotEmpty &&
                                Uri.tryParse(sparePart.imageUrl)
                                        ?.hasAbsolutePath ==
                                    true
                            ? sparePart.imageUrl
                            : null;

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BuyScreen(sparePartId: sparePart.id),
                              ),
                            );
                          },
                          child: Container(
                            width: 85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xffEBEBEB),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (imageUrl != null)
                                  Image.network(
                                    imageUrl,
                                    height: 65,
                                    width: 75,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/no_image.png',
                                        height: 73,
                                        width: 81,
                                      );
                                    },
                                  )
                                else
                                  Image.asset(
                                    'assets/images/no_image.png',
                                    height: 73,
                                    width: 81,
                                  ),
                                const SizedBox(height: 10),
                                Text(
                                  sparePart.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      sparePart.make,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Text('   '),
                                    Text(
                                      '${sparePart.year}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Rs. ${sparePart.price}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
