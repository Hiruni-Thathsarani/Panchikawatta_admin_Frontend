import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panchikawatta/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseStorage _storage = FirebaseStorage.instance;

Future<UserCredential?> createAccount(
    String username, String password, String email, String? imagePath) async {
  try {
    print("Attempting to create user with email: $email");

    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = userCredential.user;

    if (user != null) {
      print("User is successfully created");

      await user.updateDisplayName(
          username); // Update the user's display name (this is a method from the Firebase Auth package

      String? downloadUrl;
      if (imagePath != null) {
        // Upload the image to Firebase Storage
        File file = File(imagePath);
        TaskSnapshot snapshot = await _storage
            .ref('profile_pictures/${user.uid}')
            .putFile(
                file); // Upload the file to the profile_pictures folder in Firebase Storage

        // Get the download URL
        downloadUrl = await snapshot.ref.getDownloadURL();
      }

      // send user data to the firebase cloud firestore database
      await _firestore.collection("users").doc(_auth.currentUser?.uid).set({
        "name": username,
        "email": email,
        "profile_picture": downloadUrl,
        "vehicle_photo": downloadUrl,
      });
      print("User ID: ${user.uid}");

      return userCredential;
    } else {
      print("Some error happend");
      return userCredential;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<void> uploadVehiclePhoto(String uid, String imagePath) async {
  try {
    File file = File(imagePath);

    // Upload the file to Firebase Storage
    TaskSnapshot snapshot = await _storage
        .ref('profile_pictures/$uid/${file.path.split('/').last}')
        .putFile(file);

    // Get the download URL of the uploaded image
    String downloadUrl = await snapshot.ref.getDownloadURL();

    // Update the user document in Firestore with the vehicle photo URL
    await _firestore.collection("users").doc(uid).update({
      "vehicle_photo": downloadUrl,
    });

    print("Vehicle photo uploaded successfully");
  } catch (e) {
    // Handle any errors that occur during the process
    print("Error uploading vehicle photo: $e");
    throw e; // Optionally rethrow the exception to handle it elsewhere if needed
  }
}

Future<UserCredential?> logout(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => login()));
    });
    print("Logout successful");
    return null;
  } catch (e) {
    print(e);
    return null;
  }
}
