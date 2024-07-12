import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatelessWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;

  ChatRoom({required this.userMap, required this.chatRoomId});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // leading: CircleAvatar(
        //             backgroundImage: results[index]['profile_picture'] == null 
        //               ? null 
        //               : NetworkImage(results[index]['profile_picture']),
        //             child: results[index]['profile_picture'] == null 
        //               ? Icon(Icons.person) 
        //               : null,
        //           ),,
        title: Text(userMap['name'], style: const TextStyle(color: Color(0xFFFF5C01), fontSize: 25)),
        actions: [
          IconButton(
            icon:  const Icon(Icons.more_vert, color: Colors.black, size: 28),
            onPressed: () {
              // Display the input field for search
            },
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0), 
          child: Divider(
            color: Colors.grey,  // Change this color to the one you prefer
            height: 1.0,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                  .collection('chatRoom')
                  .doc(chatRoomId)
                  .collection('chats')
                  .orderBy('time', descending: false)
                  .snapshots(), 
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, Index) {
                        Map<String, dynamic> map = snapshot.data!.docs[Index].data() as Map<String, dynamic>;
                        return messages(size, map); //Text(snapshot.data!.docs[Index]['message']);
                      }
                    );
                  } else {
                    return Container();
                  }
                }),
              ),

            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 14,
                width: size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      height: size.height / 10,
                      width: size.width / 1.3,
                      child: TextField(
                        controller: _message,
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none
                          ),
                          filled: true,
                          fillColor: const Color(0xFFFCB891)
                        ),
                      ),
                    ),
                  
                    IconButton(
                      onPressed: onSendMessage, 
                      icon: const Icon(Icons.send, color: Color(0xFFFCB891), size: 38),
                    ), 
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to send a message
  void onSendMessage() async {
    if(_message.text.isNotEmpty) {
      Map<String, dynamic> message = {
        'sendby' : _auth.currentUser!.displayName,
        'message': _message.text,
        'time' : FieldValue.serverTimestamp(),
      };

      await _firestore 
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .add(message);

      _message.clear();
    } else {
      print('Enter a message to send');
    }
  }

  // Widget to display messages
  Widget messages(Size size, Map<String,dynamic> map ) {
    return Container(
      width: size.width,
      alignment: map['sendby'] == _auth.currentUser!.displayName 
        ? Alignment.centerRight 
        : Alignment.centerLeft,

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          color: map['sendby'] == _auth.currentUser!.displayName 
            ? const Color(0xFFFCB891) 
            : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          map['message'],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}