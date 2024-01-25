import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  // Instance of FirebaseAuth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Instance of Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign user in with email and password
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Create a new user with email and password
  Future<UserCredential> signUpWithEmailAndPassword(
    String username,
    String email, 
    String password,
    String firstName,
    String lastName,
    String dateOfBirth,
    String phoneNumber,
    String description
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create a document for the user in the 'users' collection
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth,
        'phoneNumber': phoneNumber,
        'description': description,
        'friends': [] // Initialize an empty friends list
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign user out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
