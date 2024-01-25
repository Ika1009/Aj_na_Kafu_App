import 'dart:async';
import 'dart:ui';

import 'package:project/models/map_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindFriends extends StatefulWidget {
  const FindFriends({Key? key}) : super(key: key);

  @override
  _FindFriendsState createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(43.3209, 21.8958),
    zoom: 14.4746,
  );

  final Set<Marker> _markers = {};
  late GoogleMapController _controller;

  final List<dynamic> _contacts = const [
    {
      "name": "Me",
      "position": LatLng(43.315092426177465, 21.929081988723677),
      "marker": 'assets/images/avatar-1.png',
      "image": 'assets/images/avatar-1.png',
    },
    {
      "name": "Nikola",
      "position": LatLng(43.307134037870505, 21.930686454044327),
      "marker": 'assets/images/avatar-2.png',
      "image": 'assets/images/avatar-2.png',
    },
    {
      "name": "Ilija",
      "position": LatLng(43.3192165679354, 21.890076638701004),
      "marker": 'assets/images/avatar-3.png',
      "image": 'assets/images/avatar-3.png',
    },
    {
      "name": "Mila",
      "position": LatLng(43.31902510484924, 21.922130145746458),
      "marker": 'assets/images/avatar-4.png',
      "image": 'assets/images/avatar-4.png',
    },
    {
      "name": "Djuka",
      "position": LatLng(43.32188038893505, 21.91620402520917),
      "marker": 'assets/markers/marker-1.png',
      "image": 'assets/images/avatar-1.png',
    },
    {
      "name": "Uros",
      "position": LatLng(43.322434376781445, 21.917747696373194),
      "marker": 'assets/markers/marker-5.png',
      "image": 'assets/images/avatar-5.png',
    },
    {
      "name": "Iskra",
      "position": LatLng(43.3152883710363, 21.89068448986699),
      "marker": 'assets/markers/marker-6.png',
      "image": 'assets/images/avatar-6.png',
    },
    {
      "name": "Golub",
      "position": LatLng(43.33125751774165, 21.91157592948357),
      "marker": 'assets/markers/marker-7.png',
      "image": 'assets/images/avatar-7.png',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    createMarkers(context);

    return Scaffold(
        body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            markers: _markers,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              controller.setMapStyle(MapStyle().aubergine);
            },
          ),
        Positioned(
          bottom: 20,
          left: 10,
          right: 10,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _controller.moveCamera(
                          CameraUpdate.newLatLng(_contacts[index]["position"]));
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            _contacts[index]['image'],
                            width: 60,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _contacts[index]["name"],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
        )
      ],
    ));
  }

  createMarkers(BuildContext context) {
    Marker marker;

    _contacts.forEach((contact) async {
      marker = Marker(
        markerId: MarkerId(contact['name']),
        position: contact['position'],
        icon: await _getAssetIcon(context, contact['marker'], 50, 50)
            .then((value) => value),
        infoWindow: InfoWindow(
          title: contact['name'],
          snippet: 'Street 6 . 2min ago',
        ),
      );

      setState(() {
        _markers.add(marker);
      });
    });
  }

  Future<BitmapDescriptor> _getAssetIcon(
      BuildContext context, String icon, int width, int height) async {
    final ImageConfiguration config = createLocalImageConfiguration(context);
    final Completer<BitmapDescriptor> bitmapIcon =
        Completer<BitmapDescriptor>();

    AssetImage(icon).resolve(config).addListener(
      ImageStreamListener((ImageInfo image, bool sync) async {
        final ByteData? byteData =
            await image.image.toByteData(format: ImageByteFormat.png);
        if (byteData != null) {
          // Resize the image
          final codec = await instantiateImageCodec(
              byteData.buffer.asUint8List(),
              targetWidth: width,
              targetHeight: height);
          final FrameInfo frameInfo = await codec.getNextFrame();
          final ByteData? resizedBytes =
              await frameInfo.image.toByteData(format: ImageByteFormat.png);
          final BitmapDescriptor bitmap =
              BitmapDescriptor.fromBytes(resizedBytes!.buffer.asUint8List());
          bitmapIcon.complete(bitmap);
        }
      }),
    );

    return await bitmapIcon.future;
  }
}
