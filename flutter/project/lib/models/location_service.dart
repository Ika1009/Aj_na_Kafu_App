import 'package:geolocator/geolocator.dart';

class LocationService {
  // Function to get the user's current location
  Future<Position?> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled; request the user to enable them
      return Future.error('Lokacija nije uključena. Molimo Vas uključite lokaciju u podešavanjima telefona.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied; next time try requesting permissions again
        return Future.error('Pristup lokaciji nije odobren.');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever; handle appropriately
      return Future.error(
        'Location permissions are permanently denied, cannot request permissions.');
    } 

    // When we reach here, permissions are granted; proceed to get the location
    return await Geolocator.getCurrentPosition();
  }
}
