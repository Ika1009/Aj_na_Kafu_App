import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:project/constants.dart';
import 'package:project/models/map_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  final Set<Marker> _allUserMarkers = {};
  final Set<Marker> _friendMarkers = {};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(43.3209, 21.8958),
    zoom: 14.4746,
  );

  Set<Marker> _markers = {};

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
        _markers = Set.from(_friendMarkers);
      });
    } catch (e) {
      //print('Error initializing markers: $e');
    }
  }

  void toggleUserDisplayMode() {
    setState(() {
      showFriends = !showFriends;
      _markers = showFriends ? _friendMarkers : _allUserMarkers;
    });
  }

  void changeUsersAvailabilityStatus() {
    setState(() {
      currentUserModel!.status = !currentUserModel!.status;
    });
    UserService userService = UserService();
    userService.toggleCurrentUserStatus();
  }

  // Utility function to create markers from a list of user data
  Future<void> createMarkersFromUsers(List<Map<String, dynamic>> usersData, Set<Marker> markersSet) async {
    for (var user in usersData) {
      BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker; // Default marker icon

      try {
        // Attempt to get the custom image for the marker
        final String markerUrl = user['imageUrl'] ?? ''; // Provide a default or placeholder image URL if necessary
        markerIcon = await getNetworkImageAsMarkerIcon(markerUrl);
      } catch (e) {
        //print('Error fetching image for user: ${user['uid']}. Using default marker icon. Error: $e');
      }

      try {
        // Continue to create the marker with whatever icon we have (custom or default)
        final double latitude = (user['location']['latitude'] as num).toDouble();
        final double longitude = (user['location']['longitude'] as num).toDouble();
        final String name = "${user['firstName']} ${user['lastName']}";

        final marker = Marker(
          markerId: MarkerId(name),
          position: LatLng(latitude, longitude),
          icon: markerIcon,
          infoWindow: InfoWindow(
            title: name,
            snippet: user['description'], // Use the description or another field
          ),
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
            GoogleMap(
              initialCameraPosition: _kGooglePlex,
              markers: _markers,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(MapStyle().retro);
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
                  currentUserModel!.status ? "Otkaži izlazak" : "Aj Na Kafu", // Text changes based on `isAvailable`
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
  // Function to fetch an image from the network and convert it to a BitmapDescriptor
  Future<BitmapDescriptor> getNetworkImageAsMarkerIcon(String url, {int width = 120, int height = 120}) async {
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to load network image.');
    }
    final Uint8List bytes = response.bodyBytes;
    final Codec codec = await instantiateImageCodec(bytes, targetWidth: width, targetHeight: height);
    final FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? byteData = await frameInfo.image.toByteData(format: ImageByteFormat.png);
    if (byteData == null) {
      throw Exception('Failed to convert image to byte data.');
    }
    final Uint8List resizedBytes = byteData.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(resizedBytes);
  }

}