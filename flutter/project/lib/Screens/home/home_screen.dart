import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project/Screens/map/map_screen.dart';
import 'package:project/services/location_service.dart';
import 'package:project/screens/profile/profile_screen.dart';
import 'package:project/screens/chats/chats_screen.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int _selectedIndex = 1;
  bool locationEnabled = false;
  Position? location;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    const ChatsScreen(),
    const MapScreen(),
    const ProfileScreen(),
  ];

  Future<Position?> _getUserLocation() {
    LocationService locationService = LocationService();
    return locationService.getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Position?>(
        future: _getUserLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            locationEnabled = true;
            location = snapshot.data;
          }
          return _pages[_selectedIndex];
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFF757575), width: 0.2),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.location_pin),
              label: 'Map',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedItemColor: secondaryColor,
        ),
      ),
    );
  }
}
