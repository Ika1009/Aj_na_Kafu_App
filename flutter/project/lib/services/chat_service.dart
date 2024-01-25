import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/models/message.dart';
import 'package:project/models/user_data.dart';
import 'package:project/services/current_user_service.dart';

class ChatService extends ChangeNotifier {
  // Get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // SEND MESSAGE
  Future<void> sendMessage(String receiverId, String message) async {
    final UserService userService = UserService();
    final UserData? currentUserData = await userService.getCurrentUserData();
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    if(currentUserData == null) throw Exception("Trenutni korisnik nije pronađen.");
    
    // Create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderName: "${currentUserData.firstName} ${currentUserData.lastName}",
      receiverId: receiverId,
      timestamp: Timestamp.now(),
      message: message,
    );

    // Construct chat id from current user id and receiver id (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // Sort the ids (this ensures the chat room id is always the same for any pair of users)
    String chatRoomId = ids.join("_"); // Combine the ids into a single string to use as a chat room id

    // Add new message to database
  await _fireStore
      .collection('chat_rooms')
      .doc(chatRoomId)
      .collection('messages')
      .add(newMessage.toMap());
  }

  // GET MESSAGES
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // Construct chat room id (sorted to ensure it matches the id used when sending)
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

}

