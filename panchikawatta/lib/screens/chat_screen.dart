import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panchikawatta/components/input_fields.dart';
import 'package:panchikawatta/screens/chat_room.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isSearching = false;
  final FocusNode _searchfocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();  
  List<Map<String, dynamic>>? searchResults = []; //Empty list of maps, where each map has string keys and values of any type (dynamic).
  String? currentUserId;
  final _auth = FirebaseAuth.instance;

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
      return '$user1$user2';
    } else {
      return '$user2$user1';
    }
  }

  @override
  void initState() {  //This function will call when the _buildSearchResults() widget is loaded
    super.initState();
    // currentUserId = FirebaseAuth.instance.currentUser!.uid;  //Get the current user's id
    _searchController.addListener(() {  //Listen to the changes in the search field. This will call every time the searchText change
      if (_searchController.text.isEmpty) {
        return ;  //If the search field is empty, do nothing.
      } else {
        onSearch(_searchController.text); //If the search field is not empty, call the onSearch function.
      }
    });
  }

  @override
  void dispose() {  //This function will call when the _buildSearchResults() widget is disposed/permanently removed from the screen
    _searchController.dispose();  //cleans up the resources used by _searchController.
    super.dispose();
  }

  void onSearch(String searchText) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    await _firestore
    .collection('users')
    .where('email', isGreaterThanOrEqualTo: searchText) 
    .where('email', isLessThan: searchText + 'z')   //The 'z' is added to the searchText to ensure that all possible strings that start with searchText are included in the results.
    .get()
    .then((value) {
      setState(() {
        searchResults = value.docs  //Access the docs property of the value object. This property is a list of all the documents returned by a Firestore query.
        .map((doc) => {'uid' : doc.id, ...doc.data(),}) //A method that transforms each item in the list. For each document (doc), it calls the data() method, which returns a Map<String, dynamic> representing the data in the document.
        // .where((user) => user['uid'] != currentUserId)  //A method that filters the list. It removes the current user from the search results.
        .toList();  //A method that converts the result of the map operation (which is an Iterable) back into a List.
      });
      print (searchResults);
    });

    setState(() {
      searchResults = searchResults!.where((user) => user['uid'] != currentUserId).toList();
    });
  }

  Widget _buildSearchResults() {
    return ListView.builder(  //A scrollable list of widgets that are created on demand.
      itemCount: searchResults?.length ?? 0, //searchResults!.isEmpty ? 0 : searchResults!.length,
      itemBuilder: (context, index) {   //The itemBuilder function is called for each item in the list.
        final results = searchResults;
        if (results != null && index < results.length) {
          // if (results[index]['uid'] == currentUserId) {
          //   return Container();
          // } else {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.05,  // left
                  0,                                        // top
                  MediaQuery.of(context).size.width * 0.05,  // right
                  0,                                        // bottom
                ),
              child: Container( 
                height: 75,
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFFF5C01))),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: results[index]['profile_picture'] == null 
                      ? null 
                      : NetworkImage(results[index]['profile_picture']),
                    child: results[index]['profile_picture'] == null 
                      ? const Icon(Icons.person) 
                      : null,
                  ),
                  onTap: () { 
                    String roomId = chatRoomId(
                      _auth.currentUser!.displayName ?? 'Name',
                      searchResults![index]['name'],
                    );

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ChatRoom(
                          chatRoomId: roomId,
                          userMap: searchResults![index],
                        )
                      )
                    );
                  },
                  title: Text(results[index]['name'], style: const TextStyle(fontSize: 17)),
                  subtitle: Text(results[index]['email'], style: const TextStyle(fontSize: 15)),
                ),
              ),
            );
          // }
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching ? Container() : IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 26),
          onPressed: () {
            // Navigate to the previous page
            Navigator.pop(context);
          },
        ),
        title: _isSearching ?
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: InputFields(
                  hintText: 'Search..', 
                  width1: 0.8,
                  focusNode: _searchfocusNode,
                  controller: _searchController,
                ),
              ),
            ],
          ) :
          const Text('Chats', style: TextStyle(color: Color(0xFFFF5C01), fontSize: 28)),
        actions: [
          IconButton(
            icon:  Icon(_isSearching ? Icons.close : Icons.search, color: Colors.black, size: 28),
            onPressed: () {
              // Display the input field for search
              setState(() {
                if (_isSearching) {
                  _searchfocusNode.unfocus();
                } 
                _isSearching = !_isSearching;
              });
            },
          ),
        ],
      ),

      body: _isSearching ? _buildSearchResults() : Container(), 

    );
  }
}