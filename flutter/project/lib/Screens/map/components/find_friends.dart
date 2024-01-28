import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:project/constants.dart';
import 'package:project/models/map_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/services/users_manager.dart';

class FindFriends extends StatefulWidget {
  const FindFriends({Key? key}) : super(key: key);

  @override
  State<FindFriends> createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  final UsersManager usersManager = UsersManager(); 
  User? currentUser = FirebaseAuth.instance.currentUser;

  final Set<Marker> _allUserMarkers = {};
  final Set<Marker> _friendMarkers = {};
  bool _showAllUsers = false; // Flag to track the current mode

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(43.3209, 21.8958),
    zoom: 14.4746,
  );

  Set<Marker> _markers = {};

  Future<void> initMarkers() async {
    // Fetch all users and create markers
    List<Map<String, dynamic>> allUsers = await usersManager.getAllUsers();
    await createMarkersFromUsers(allUsers, _allUserMarkers);

    // Fetch friends and create markers
    List<Map<String, dynamic>> friends = await usersManager.getFriendsOfUser(currentUser!.uid);
    await createMarkersFromUsers(friends, _friendMarkers);

    // Set initial markers to display friends
    setState(() {
      _markers = Set.from(_friendMarkers);
    });
  }

  void toggleUserDisplayMode() {
    setState(() {
      _showAllUsers = !_showAllUsers;
      _markers = _showAllUsers ? _allUserMarkers : _friendMarkers;
    });
  }
  // Utility function to create markers from a list of user data
  Future<void> createMarkersFromUsers(List<Map<String, dynamic>> usersData, Set<Marker> markersSet) async {
    for (var user in usersData) {
      final markerIcon = await getNetworkImageAsMarkerIcon(user['marker']);
      final marker = Marker(
        markerId: MarkerId(user['name']),
        position: LatLng(
          user['location']['latitude'], 
          user['location']['longitude']
        ),
        icon: markerIcon,
        infoWindow: InfoWindow(
          title: user['name'],
          snippet: 'aktivan',
        ),
      );

      markersSet.add(marker);
    }

    // If needed, update the UI to show new markers
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
    ));
        initMarkers();
  }

  @override
  Widget build(BuildContext context) {
    // Check if currentUser is null and handle accordingly
    if (currentUser == null) {
      // Return a widget that handles this case, like a login prompt or an error message
      return const Center(
        child: Text('User not logged in.'),
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
              top: 15,
              left: 40,
              right: 40,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SvgPicture.asset(
                        'assets/icons/searchperson.svg',
                        height: 24,
                        width: 24,
                      ),
                    ),
                    const Text(
                      'Pretraži...',
                      style: TextStyle(
                        color: Color(0xFF757575),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
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
                onPressed: toggleUserDisplayMode, // Hook up the toggle function here
                child: const Text(
                  "Aj Na Kafu",
                  style: TextStyle(
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
  Future<BitmapDescriptor> getNetworkImageAsMarkerIcon(String url, {int width = 100, int height = 100}) async {
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