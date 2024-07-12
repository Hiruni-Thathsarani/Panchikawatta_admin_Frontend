 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panchikawatta/global/common/toast.dart';

class FirebaseAuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String Password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: Password);
      return credential.user;
    }  on FirebaseAuthException catch (e){

      if(e.code == 'email-already-in-use') {
        showToast(message:'The email addreess is already in use');
      }
    else{
      showToast(message:'An error occurred: ${e.code}');
    }
    
    }
    return null;
  
}
Future<User?> signInWithEmailAndPassword(
     String email, String Password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: Password);
      return credential.user;
    }  on FirebaseAuthException catch(e){
        if(e.code == 'user-not-found'|| e.code == 'wrong-password') {
        showToast(message:'Invalid email or password');
      }
    
    }
    return null;
  
}
    Future<bool> sendEmailVerification(User user, BuildContext context) async {
    try {
      await user.sendEmailVerification();
      return true;
    } catch (e) {
      print("Failed to send verification email: $e");
      return false;
    }

  }
Future<bool> isEmailVerified(User user) async {
    await user.reload();
    return user.emailVerified;
  }
}
 