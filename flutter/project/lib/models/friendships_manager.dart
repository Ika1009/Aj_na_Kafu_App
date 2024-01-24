import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsManager {
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
        print('Error fetching friend data: $e');
      }
    }

    return friendsList;
  }
}
