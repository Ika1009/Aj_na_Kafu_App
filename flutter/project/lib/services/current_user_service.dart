import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/models/user_data.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the current user's UID
  String? getCurrentUserId() {
    final user = _auth.currentUser;
    return user?.uid;
  }

  // Retrieve user data from Firestore and parse it into a UserData object
  Future<UserData?> getCurrentUserData() async {
    final userId = getCurrentUserId();
    if (userId == null) {
      return null; // User not logged in
    }

    try {
      final userDataSnapshot = await _firestore.collection('users').doc(userId).get();

      if (userDataSnapshot.exists) {
        final userData = userDataSnapshot.data() as Map<String, dynamic>;
        return UserData(
          email: userData['email'] ?? '',
          userName: userData['userName'] ?? '',
          firstName: userData['firstName'] ?? '',
          lastName: userData['lastName'] ?? '',
          dateOfBirth: userData['dateOfBirth'] ?? '',
          phoneNumber: userData['phoneNumber'] ?? '',
          description: userData['description'] ?? '',
          uid: userId,
          username: userData['username'] ?? '',
          friends: List<String>.from(userData['friends'] ?? []),
        );
      } else {
        return null; // User data not found in Firestore
      }
    } catch (e) {
      //print('Error retrieving user data: $e');
      return null; // Error occurred while retrieving user data
    }
  }
}
