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
  late Future<void> friendsFuture;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(43.3209, 21.8958),
    zoom: 14.4746,
  );

  Future<List<Map<String, dynamic>>> fetchData(UsersManager usersManager) async {
    List<Map<String, dynamic>> contacts = [];
    var friends = await usersManager.getFriendsOfUser(currentUser!.uid);

    for (var friend in friends) {
      contacts.add({
        "name": friend['firstName'], 
        "position": LatLng(friend['location']['latitude'], friend['location']['longitude']),
        "marker": friend['imageUrl'],
      });
    }

    return contacts;
  } 

  Future<void> createMarkers() async {
    List<Map<String, dynamic>> contacts = await fetchData(usersManager);
    Marker marker;
    print(contacts);
    contacts.forEach((contact) async {
      marker = Marker(
        markerId: MarkerId(contact['name']),
        position: contact['position'],
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: contact['name'],
          snippet: 'aktivan',
        ),
      );

      setState(() {
        _markers.add(marker);
      });
    });
  }

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
    ));
    friendsFuture = createMarkers();
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
            FutureBuilder(
              future: friendsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading friends.'));
                }
                return GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  markers: _markers,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    controller.setMapStyle(MapStyle().retro);
                  },
                );
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
          ],
        ),
      ),
    );
  }

  Future<BitmapDescriptor> getNetworkImageAsMarkerIcon(String url, {int width = 100, int height = 100}) async {
    final http.Response response = await http.get(Uri.parse(url));
    final Uint8List bytes = response.bodyBytes;

    // Resize the image using dart:ui as required
    final Codec codec = await instantiateImageCodec(bytes, targetWidth: width, targetHeight: height);
    final FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? byteData = await frameInfo.image.toByteData(format: ImageByteFormat.png);
    final Uint8List resizedBytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(resizedBytes);
  }
}