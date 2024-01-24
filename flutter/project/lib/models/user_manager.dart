import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserManager {
  // Singleton instance
  static final UserManager _instance = UserManager._internal();

  // Factory constructor
  factory UserManager() {
    return _instance;
  }

  // Internal constructor
  UserManager._internal();

  // User properties
  String? uid;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? phoneNumber;
  String? description;
  Position? location;
  List<String> friends = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to populate user data
  void setUser({
    String? uid,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? phoneNumber,
    String? description,
    List<String>? friends,
  }) {
    this.uid = uid;
    this.username = username;
    this.email = email;
    this.firstName = firstName;
    this.lastName = lastName;
    this.dateOfBirth = dateOfBirth;
    this.phoneNumber = phoneNumber;
    this.description = description;
    if (friends != null) {
      this.friends = friends;
    }
  }

  // Method to clear user data on sign out
  void clearUser() {
    uid = null;
    username = null;
    email = null;
    firstName = null;
    lastName = null;
    dateOfBirth = null;
    phoneNumber = null;
    description = null;
    friends.clear();
  }

  // Method to add a friend
  Future<void> addFriend(String friendUid) async {
    if (uid == null || friendUid.isEmpty) {
      throw Exception('Invalidna operacija: Korisnikov UID ili UID prijatelja nedostaje');
    }

    // Check if the friendUid is already in the friends list
    if (!friends.contains(friendUid)) {
      // Update the local friends list
      friends.add(friendUid);

      // Update the friends list in Firestore
      await _firestore.collection('users').doc(uid).update({
        'friends': FieldValue.arrayUnion([friendUid])
      });
    }
  }
}
