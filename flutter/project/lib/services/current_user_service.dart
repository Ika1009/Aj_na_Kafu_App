import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project/models/user_data.dart';
import 'package:project/models/user_model.dart';
import 'package:project/services/auth_service.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the current user's UID
  String? getCurrentUserId() {
    final user = _auth.currentUser;
    return user?.uid;
  }

  // Retrieve user data from Firestore and parse it into a UserData object
  Future<UserModel?> getCurrentUserModel() async {
    final userId = getCurrentUserId();
    if (userId == null) {
      return null; // User not logged in
    }

    try {
      final userDataSnapshot = await _firestore.collection('users').doc(userId).get();

      if (userDataSnapshot.exists) {
        final userData = userDataSnapshot.data() as Map<String, dynamic>;
        return UserModel.fromMap(userData);
      } else {
        return null; // User data not found in Firestore
      }
    } catch (e) {
      //print('Error retrieving user data: $e');
      return null; // Error occurred while retrieving user data
    }
  }

  // Update current user data
  Future<void> updateCurrentUserData(UserData userData, Uint8List? imageData) async {
    final userId = getCurrentUserId();
    if (userId == null) {
      throw Exception("User not logged in");
    }

    try {
      await _firestore.collection('users').doc(userId).update({
        'email': userData.email,
        'username': userData.username,
        'firstName': userData.firstName,
        'lastName': userData.lastName,
        'dateOfBirth': userData.dateOfBirth,
        'phoneNumber': userData.phoneNumber,
        'description': userData.description,
        'imageUrl': userData.imageUrl,
        // Add other fields as needed
      });
      if(imageData != null) {
        AuthService authService = AuthService();
        await authService.uploadImage(imageData, userId);
      }
    } catch (e) {
      // Handle errors here
      //print('Error updating user data: $e');
      throw Exception("Error updating user data");
    }
  }

  Future<void> updateCurrentUserPosition(Position? position) async {
    final userId = getCurrentUserId();
    if (userId == null || position == null) {
      throw Exception("User not logged in");
    } 

    try {
      Map<String, dynamic> positionMap = {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'accuracy': position.accuracy,
        'timestamp': position.timestamp.toIso8601String(), // Firestore does not support DateTime directly
      };

      await _firestore.collection('users').doc(userId).update({
        'location': positionMap,
      });
    } catch (e) {
      // Handle errors here
      throw Exception("Error updating user position: $e");
    }
  }

  Future<void> toggleCurrentUserStatus() async {
    final userId = getCurrentUserId();
    if (userId == null) {
      throw Exception("User not logged in");
    }

    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists && userDoc.data() != null) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final currentStatus = userData['status'] as bool? ?? false; // Default to false if not set
        await _firestore.collection('users').doc(userId).update({
          'status': !currentStatus, // Toggle the status
        });
      } else {
        throw Exception("User document does not exist");
      }
    } catch (e) {
      // Handle errors here
      throw Exception("Error toggling user status: $e");
    }
  }
}
