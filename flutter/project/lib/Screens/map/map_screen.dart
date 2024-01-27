import 'package:flutter/material.dart';
import 'package:project/Screens/map/components/find_friends.dart';
import 'package:project/services/users_manager.dart';

class MapScreen extends StatelessWidget {
  static String routeName = "/map";
  const MapScreen({super.key});

  Future<List<Map<String, dynamic>>> fetchData(UsersManager usersManager) async {
    var friends = await usersManager.getFriendsOfUser("userUid");
    var allUsers = await usersManager.getAllUsers();
    
    return friends; // If getAllUsers is not available
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FindFriends(),
    );
  }
}
