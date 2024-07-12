import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panchikawatta/screens/chat_screen.dart';
import 'package:panchikawatta/screens/SignUp/sign_up1.dart';

class search_page1 extends StatefulWidget {
  const search_page1({Key? key}) : super(key: key);

  @override
  _search_pageState createState() => _search_pageState();
}

class _search_pageState extends State<search_page1> {
  // const search_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(), // Empty container to push PopupMenuButton to the right
            Align(
              alignment: Alignment.centerRight,
              child: PopupMenuButton(
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: const Text('Sign Out'),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushNamed(context, "SplashScreen");
                      });
                    },
                  ),
                  PopupMenuItem(
                    child: const Text('Sign Up'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => sign_up1()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Center(
        // child: Text('Search Page Content'),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => ChatScreen()));
          },
          child: const Text('chat'),
        ),
      ),
    );
  }
}
