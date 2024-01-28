import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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
    String username, String email, String password, String firstName, String lastName, 
    String dateOfBirth, String phoneNumber, String description,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create a document for the user in the 'users' collection
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'username': username,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth,
        'phoneNumber': phoneNumber,
        'description': description,
        'imageUrl': 'https://bonanza.mycpanel.rs/ajnakafu/images/profile_basic.png', // Default imageUrl
        'friends': [], // Initialize an empty friends list
        'sentRequests': [], // Initialize an empty array for sent friend requests
        'receivedRequests': [], // Initialize an empty array for received friend requests
        'status': false, // Initialize the availability status to false
        'location': null // Initialize location as null
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      throw Exception(e.code);
    }
  }


  // Sign user out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<String> uploadImage(Uint8List imageData, String userUID) async {
    final uri = Uri.parse('https://bonanza.mycpanel.rs/ajnakafu/upload_image.php');
    try {
      final request = http.MultipartRequest('POST', uri);

      // Add userUID as a field in the request
      request.fields['userUID'] = userUID;

      // Add the image data to the request
      final mimeType = MediaType('image', 'jpeg'); // Adjust the mime type as needed
      final multipartFile = http.MultipartFile.fromBytes('file', imageData, filename: '$userUID.jpg', contentType: mimeType);
      request.files.add(multipartFile);

      // Send the request and get the response
      final response = await request.send();
      if (response.statusCode == 200) {
        // Image uploaded successfully, parse the response to get the image URL
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final imageUrl = json.decode(responseString)['imageUrl'];
        return imageUrl;
      } else {
        throw Exception('Image upload failed with status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Image upload failed: $e');
    }
  }

  Future<void> uploadUserProfileImageURL(String userUID, String imageUrl) async {
    try {
      // Reference to the Firestore document for the user
      DocumentReference userDocRef = _firestore.collection('users').doc(userUID);

      // Update the user document with the new image URL
      await userDocRef.update({
        'imageUrl': imageUrl,
      });
    } catch (e) {
      throw Exception('Failed to update user profile image: $e');
    }
  }
}