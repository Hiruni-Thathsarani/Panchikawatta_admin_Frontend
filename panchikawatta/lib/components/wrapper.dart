// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:panchikawatta/global/common/toast.dart';
// import 'package:panchikawatta/main.dart';
// import 'package:panchikawatta/screens/SplashScreen.dart';
// import 'package:panchikawatta/screens/login.dart';
// import 'package:firebase_core/firebase_core.dart';
 
// class wrapper extends StatelessWidget {
//   const wrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: StreamBuilder(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Text("Error"),
//                 );
//               } else {
//                 if (snapshot.data == null) {
                 
//                   return const SplashScreen();
//                 }
//                 else{
//                    showToast(message: " yor are  successfully signed in");
//                   return const MyHomePage();
//                 }
//                 }
              
//             }));
//   }
// }
