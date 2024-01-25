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

  static const List<String> _titles = ["Chats", "Map", "Profile"];

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
              leading: const Icon(Icons.location_pin),
              title: const Text("Map"),
              onTap: () {},
            ),
          ],
        ),
      ),
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
      bottomNavigationBar: BottomNavigationBar(
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
        selectedItemColor: primaryColor,
      ),
    );
  }
}
