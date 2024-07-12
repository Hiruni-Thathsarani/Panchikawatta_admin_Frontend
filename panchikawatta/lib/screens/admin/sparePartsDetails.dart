// import 'package:flutter/material.dart';
// import 'package:panchikawatta/screens/admin/admin_page.dart';


// class SparePartsApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xFFFF5C01), // Set custom color
//           title: const Text('Spare Parts Details'),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//                             return const AdminPage();
//                           }));
//                         },
//           ),
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Find something...',
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 3,
//                 padding: const EdgeInsets.all(8.0),
//                 children: [
//                   _buildCategoryItem(Icons.directions_car, 'Interior'),
//                   _buildCategoryItem(Icons.directions_car_outlined, 'Exterior'),
//                   _buildCategoryItem(Icons.speed, 'Performance'),
//                   _buildCategoryItem(Icons.lightbulb, 'Lighting'),
//                   _buildCategoryItem(Icons.wheelchair_pickup, 'Wheels & Tires'),
//                   _buildCategoryItem(Icons.build, 'Repair Parts'),
//                   _buildCategoryItem(Icons.audiotrack, 'Audio'),
//                   _buildCategoryItem(Icons.build_circle, 'Body Parts'),
//                   _buildCategoryItem(Icons.car_repair, 'Car Service'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryItem(IconData icon, String label) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(icon, size: 40.0),
//         const SizedBox(height: 8.0),
//         Text(label, textAlign: TextAlign.center),
//       ],
//     );
//   }
// }
