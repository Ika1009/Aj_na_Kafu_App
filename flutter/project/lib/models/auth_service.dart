import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/models/user_manager.dart';

class AuthService extends ChangeNotifier {
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign user in
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Sign in
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Reference to the user's Firestore document
      DocumentReference userDocRef = _firestore.collection('users').doc(userCredential.user!.uid);
      // Attempt to retrieve the user's document
      DocumentSnapshot userDoc = await userDocRef.get();

      // Check if the document exists
      if (!userDoc.exists) {
        // If the document does not exist, create it with default blank values
        await userDocRef.set({
          'uid': userCredential.user!.uid,
          'email': email,
          'username': '',
          'firstName': '',
          'lastName': '',
          'dateOfBirth': '',
          'phoneNumber': '',
          'description': '',
          'friends': [] // Initialize an empty friends list
        }, SetOptions(merge: true));
      }

      // Retrieve the document again to ensure it exists and to populate UserManager
      userDoc = await userDocRef.get();
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>? ?? {};

      // Set global user data in UserManager with data from Firestore or default blank values
      UserManager().setUser(
        uid: userData['uid'] ?? userCredential.user!.uid,
        email: userData['email'] ?? email,
        username: userData['username'] ?? '',
        firstName: userData['firstName'] ?? '',
        lastName: userData['lastName'] ?? '',
        dateOfBirth: userData['dateOfBirth'] ?? '',
        phoneNumber: userData['phoneNumber'] ?? '',
        description: userData['description'] ?? '',
        friends: List<String>.from(userData['friends'] ?? []), // Retrieve friends list or initialize as empty
      );

      return userCredential;
    // Catch any errors
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }


  // Create a new user
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

      // After creating the user, create a new document for the user in the users collection with additional fields
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'username': username,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth,
        'phoneNumber': phoneNumber,
        'description': description,
        'friends': [] // Initialize an empty friends list
      });

      UserManager().setUser(
        uid: userCredential.user!.uid,
        username: username,
        email: email,
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        phoneNumber: phoneNumber,
        description: description,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }


  // sign user out
  Future<void> signOut() async {
    UserManager().clearUser();
    return await FirebaseAuth.instance.signOut();
  }
}
