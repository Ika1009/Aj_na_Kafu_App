import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign user in
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      // sign in
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Optionally add a new document for the user in users collection if it doesn't already exist
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        // Default values for additional fields if the document is new
        'firstName': '',
        'lastName': '',
        'dateOfBirth': '',
        'phoneNumber': '',
        'description': '',
      }, SetOptions(merge: true));


      return userCredential;
    // catch any errors
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // create a new user
  // Create a new user with additional fields
  Future<UserCredential> signUpWithEmailAndPassword(
    String email, 
    String password,
    String firstName,
    String lastName,
    String  dateOfBirth,
    String phoneNumber,
    String description
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After creating the user, create a new document for the user in the users collection with additional fields
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth, // Store date as ISO 8601 string
        'phoneNumber': phoneNumber,
        'description': description,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign user out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
