import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_input/image_input.dart';

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
    String description,
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
        'imageUrl': 'https://bonanza.mycpanel.rs/ajnakafu/images/profile_basic.png', // Add imageUrl to the user document
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

  Future<String> uploadImage(XFile imageFile, String userUID) async {
    final uri = Uri.parse('https://bonanza.mycpanel.rs/ajnakafu/upload_image.php'); //Cuvam sliku na nasem serveru i vracam url

    try {
      final request = http.MultipartRequest('POST', uri);
      
      // Add the image file to the request
      final fileStream = http.ByteStream(imageFile.openRead());
      final length = await imageFile.length();
      final mimeType = MediaType('image', 'jpeg'); // Adjust the mime type as needed
      
      final multipartFile = http.MultipartFile('file', fileStream, length, filename: userUID, contentType: mimeType);
      
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

  Future<void> updateUserProfileImage(String userUID, String imageUrl) async {
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

