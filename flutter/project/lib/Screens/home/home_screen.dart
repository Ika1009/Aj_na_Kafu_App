import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project/models/location_service.dart';
import 'package:project/screens/profile/profile_screen.dart';
import 'package:project/screens/chats/chats_screen.dart';
import 'package:project/screens/signin/signin_screen.dart';
import 'package:project/screens/signup/signup_screen.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    const ChatsScreen(),
    const ProfileScreen(),
  ];

  static const List<String> _titles = ["Chats", "Profile"];

  Future<Position?> _getUserLocation() {
    LocationService locationService = LocationService();
    return locationService.getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text("Sign In"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Sign up"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, SignUpScreen.routeName);
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: primaryColor,
      ),
    );
  }
}