import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:panchikawatta/screens/profile_page.dart';
import 'firebase_options.dart';
import 'package:panchikawatta/screens/admin/SplashScreen.dart';
import 'screens/search_page1.dart';
import 'screens/notification_page.dart';
import 'screens/alert_page.dart';
import 'package:panchikawatta/screens/login.dart';
import 'package:panchikawatta/global/common/toast.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    print(user?.uid.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user != null ? const MyHomePage() : const SplashScreen(),
      routes: {
        'SplashScreen': (context) => const SplashScreen(),
        'login': (context) => login(),
        // Define the login route here
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const search_page1(),
    const notification_page(),
    const alert_page(),
    ProfilePage(),
  ];

  final List<Widget> _guestPages = [
    const search_page1(),
  ];

  void _onItemTapped(int index) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null && index != 0) {
      // Show a message or do nothing if the user is not logged in and tries to access other pages
      showToast(message: "Please log in to access this page.");
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Quick Help',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFFFF5C01),
        unselectedItemColor: const Color.fromARGB(255, 117, 117, 117),
      ),
    );
  }
}

// Initialize Firebase
Future<void> _initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
