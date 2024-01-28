import 'package:flutter/material.dart';
import 'package:project/screens/search/components/body.dart';
import 'package:project/services/users_manager.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/search";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> allUsers = [];
  List<Map<String, dynamic>> filteredUsers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllUsers();
  }

  Future<void> fetchAllUsers() async {
    try {
      allUsers = await UsersManager().getAllUsers();
      filteredUsers = allUsers;
    } catch (e) {
      print('Failed to fetch users: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredUsers = allUsers;
      });
    } else {
      setState(() {
        filteredUsers = allUsers
          .where((user) =>
              user['firstName'].toLowerCase().contains(query.toLowerCase()) ||
              user['lastName'].toLowerCase().contains(query.toLowerCase()) ||
              user['username'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SearchBody(),
    );
  }
}