import 'package:cloud_firestore/cloud_firestore.dart';

class UsersManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getFriendsOfUser(String userUid) async {
    List<Map<String, dynamic>> friendsList = [];
    
    // Retrieve the user's document to get their friends list
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(userUid).get();
    if (!userDoc.exists) {
      throw Exception("Korisnik nije pronadjen");
    }

    // Cast the data to Map<String, dynamic> to ensure the correct type
    var userData = userDoc.data() as Map<String, dynamic>;
    List<String> friendUids = List<String>.from(userData['friends'] ?? []);

    // Fetch each friend's details
    for (String friendUid in friendUids) {
      try {
        DocumentSnapshot friendDoc = await _firestore.collection('users').doc(friendUid).get();
        if (friendDoc.exists) {
          // Cast the friend's data to Map<String, dynamic>
          Map<String, dynamic> friendData = friendDoc.data() as Map<String, dynamic>;
          friendsList.add(friendData);
        }
      } catch (e) {
        // Handle any errors here
        //print('Error fetching friend data: $e');
      }
    }

    return friendsList;
  }
  
  // Function to get all users
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    List<Map<String, dynamic>> usersList = [];

    try {
      // Fetch all user documents from the 'users' collection
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();

      for (var doc in querySnapshot.docs) {
        // Cast each document's data to Map<String, dynamic>
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        usersList.add(userData);
      }
    } catch (e) {
      // Handle any errors here
      //print('Error fetching users data: $e');
    }

    return usersList;
  }

  // Method to send a friend request
  Future<void> sendFriendRequest(String requesterUid, String targetUid) async {
    if (requesterUid.isEmpty || targetUid.isEmpty) {
      throw Exception('Invalid UIDs provided');
    }

    // Add the target user to the requester's sent requests
    await _firestore.collection('users').doc(requesterUid).update({
      'sentRequests': FieldValue.arrayUnion([targetUid])
    });

    // Add the requester to the target user's received requests
    await _firestore.collection('users').doc(targetUid).update({
      'receivedRequests': FieldValue.arrayUnion([requesterUid])
    });
  }

  // Method to accept a friend request
  Future<void> acceptFriendRequest(String acceptingUserUid, String requestingUserUid) async {
    if (acceptingUserUid.isEmpty || requestingUserUid.isEmpty) {
      throw Exception('Invalid UIDs provided');
    }

    // Add the requesting user to the accepting user's friends list
    await _firestore.collection('users').doc(acceptingUserUid).update({
      'friends': FieldValue.arrayUnion([requestingUserUid]),
      'receivedRequests': FieldValue.arrayRemove([requestingUserUid])
    });

    // Add the accepting user to the requesting user's friends list
    await _firestore.collection('users').doc(requestingUserUid).update({
      'friends': FieldValue.arrayUnion([acceptingUserUid]),
      'sentRequests': FieldValue.arrayRemove([acceptingUserUid])
    });
  }
}
