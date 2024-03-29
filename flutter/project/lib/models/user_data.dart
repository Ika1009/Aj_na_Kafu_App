import 'package:geolocator/geolocator.dart';

class UserData {
  String email, password, username, firstName, lastName, dateOfBirth, phoneNumber, description, uid, imageUrl;
  Position? location;
  List<String> friends;

  UserData({
    this.email = '',
    this.password = '',
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.dateOfBirth = '',
    this.phoneNumber = '', 
    this.description = '',
    this.uid = '',
    this.imageUrl = '',
    this.friends = const [],
  });
}
