import 'package:flutter/material.dart';
import 'package:project/Screens/map/components/find_friends.dart';

class MapScreen extends StatelessWidget {
  static String routeName = "/map";
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FindFriends(),
    );
  }
}
