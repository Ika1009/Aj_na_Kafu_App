import 'package:flutter/material.dart';
import 'package:project/screens/profile/components/body.dart';

class FriendRequests extends StatefulWidget {
  static String routeName = "/requests";
  const FriendRequests({super.key});

  @override
  State<FriendRequests> createState() => _FriendRequestsState();
}

class _FriendRequestsState extends State<FriendRequests> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RequestsBody(),
    );
  }
}