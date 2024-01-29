import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/constants.dart';
import 'package:project/models/map_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:project/models/user_model.dart';
import 'package:project/services/current_user_service.dart';
import 'package:project/services/users_manager.dart';

class FindFriends extends StatefulWidget {
  const FindFriends({Key? key}) : super(key: key);

  @override
  State<FindFriends> createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  bool showFriends = true;
  final UsersManager usersManager = UsersManager(); 
  UserModel? currentUserModel;

  final List<MarkerData> _allUserMarkers = [];
  final List<MarkerData> _friendMarkers = [];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(43.3209, 21.8958),
    zoom: 14.4746,
  );

  late List<MarkerData> _customMarkers;

  // Function to initialize the current user model
  Future<void> initCurrentUserModel() async {
    UserService userService = UserService();
    currentUserModel = await userService.getCurrentUserModel();
    setState(() {
    });
  }
  Future<void> initMarkers() async {
    try {
      // Fetch all users and create markers for them
      List<Map<String, dynamic>> allUsers = await usersManager.getAllUsers();
      var currentUserData = currentUserModel!.toMap();
      await createMarkersFromUsers(allUsers, _allUserMarkers);

      // Fetch friends and create markers for them
      List<Map<String, dynamic>> friends = await usersManager.getFriendsOfUser(FirebaseAuth.instance.currentUser!.uid);
      
      // Add the current user's UID to the friends list if it's not already there to ensure their marker is created
      if (!friends.any((friend) => friend['uid'] == FirebaseAuth.instance.currentUser?.uid)) {
        friends.add(currentUserData);
      }
      await createMarkersFromUsers(friends, _friendMarkers);

      // Set initial markers to display friends including the current user
      setState(() {
        _customMarkers = List<MarkerData>.from(_friendMarkers);
      });
    } catch (e) {
      //print('Error initializing markers: $e');
    }
  }

  void toggleUserDisplayMode() {
    setState(() {
      showFriends = !showFriends;
      _customMarkers = showFriends ? _friendMarkers : _allUserMarkers;
    });
  }

  void changeUsersAvailabilityStatus() {
    setState(() {
      currentUserModel!.status = !currentUserModel!.status;
    });
    UserService userService = UserService();
    userService.toggleCurrentUserStatus();
  }

  _customMarker(String imagePath, bool status) {
    return Stack(
      children: [
        Icon(
          Icons.add_location,
          color: Colors.white,
          size: 50,
        ),
        Positioned(
          left: 15,
          top: 8,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(imagePath),
              ),
            ),
          ),
        )
      ],
    );
  }

  // Utility function to create markers from a list of user data
  Future<void> createMarkersFromUsers(List<Map<String, dynamic>> usersData, List<MarkerData> markersSet) async {
    for (var user in usersData) {
      try {
        // Continue to create the marker with whatever icon we have (custom or default)
        final double latitude = (user['location']['latitude'] as num).toDouble();
        final double longitude = (user['location']['longitude'] as num).toDouble();

        final marker = MarkerData(
          marker: Marker(
            markerId: const MarkerId('id-5'),
            position: LatLng(latitude, longitude)
          ),
          child: _customMarker(user['imageUrl'], user['status'])
        );

        markersSet.add(marker);
      } catch (e) {
        //print('Error creating marker for user: ${user['uid']}. Error: $e');
      }
    }

    // Update the UI if the widget is still mounted
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
    ));
    initCurrentUserModel();
    initMarkers();
  }

  @override
  Widget build(BuildContext context) {
    // Check if currentUser is null and handle accordingly
    if (FirebaseAuth.instance.currentUser == null || currentUserModel == null){
      // Return a widget that handles this case, like a login prompt or an error message
      return const Center(
        child: Text('Korisnik nije prijavljen'),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomGoogleMapMarkerBuilder(
              customMarkers: _customMarkers,
              builder: (BuildContext context, Set<Marker>? markers) {
                if (markers == null) {
                  return const Center(child: CircularProgressIndicator(color: secondaryColor));
                }
                return GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  markers: markers,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    controller.setMapStyle(MapStyle().retro);
                  },
                );
              },
            ),
            Positioned(
              top: 20,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: showFriends ? secondaryColor : backgroundColor,
                      borderRadius: BorderRadius.circular(24), 
                    ),
                    child: TextButton(
                      onPressed: toggleUserDisplayMode,
                      child: Text(
                        'Prikaži prijatelje',
                        style: TextStyle(
                          color: showFriends ? backgroundColor : secondaryColor,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 5),

                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: !showFriends ? secondaryColor : backgroundColor,
                      borderRadius: BorderRadius.circular(24), 
                    ),
                    child: TextButton(
                      onPressed: toggleUserDisplayMode,
                      child: Text(
                        'Prikaži sve ljude',
                        style: TextStyle(
                          color: !showFriends ? backgroundColor : secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              left: 20,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(secondaryColor),
                  minimumSize: MaterialStateProperty.all(const Size(double.infinity, 62)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                onPressed: changeUsersAvailabilityStatus, // Hook up the toggle function here
                child: Text(
                  currentUserModel!.status ? "Završi izlazak" : "Aj Na Kafu", // Tekst se menja na osnovu statusa
                  style: const TextStyle(
                    color: backgroundColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}