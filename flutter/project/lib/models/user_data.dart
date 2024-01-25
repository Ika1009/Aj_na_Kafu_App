import 'package:geolocator/geolocator.dart';

class UserData {
  String email;
  String password;
  String userName;
  String firstName;
  String lastName;
  String dateOfBirth;
  String phoneNumber; 
  String description;
  String uid;
  String username;
  Position? location;
  List<String> friends;

  UserData({
    this.email = '',
    this.password = '',
    this.userName = '',
    this.firstName = '',
    this.lastName = '',
    this.dateOfBirth = '',
    this.phoneNumber = '', 
    this.description = '',
    this.uid = '',
    this.username = '',
    this.friends = const [],
  });
}
