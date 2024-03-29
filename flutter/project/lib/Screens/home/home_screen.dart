import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project/Screens/map/map_screen.dart';
import 'package:project/screens/search/search_screen.dart';
import 'package:project/services/current_user_service.dart';
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
  int _selectedIndex = 2;
  bool locationEnabled = false;
  Position? location;

  final List<Widget> _pages = [
    const ChatsScreen(),
    const SearchScreen(),
    const MapScreen(),
    const ProfileScreen(),
  ];

  Future<void> _getUserLocation() async {
    LocationService locationService = LocationService();
    UserService userService = UserService();
    try {
      Position? position = await locationService.getUserLocation();
      if (position != null) {
        await userService.updateCurrentUserPosition(position);
      }
    } catch (e) {
      // Handle any errors here, such as showing an error message or logging
      //print('Failed to get location or update position: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFF757575), width: 0.2),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: backgroundColor,
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: (index) {
            if (index != _selectedIndex) {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Ćaskanja',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Traži',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_pin),
              label: 'Mapa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
          selectedItemColor: secondaryColor,
        ),
      ),
    );
  }
}