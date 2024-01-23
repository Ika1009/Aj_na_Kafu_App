import 'package:geolocator/geolocator.dart';

class UserManager {
  // Singleton instance
  static final UserManager _instance = UserManager._internal();

  // Factory constructor
  factory UserManager() {
    return _instance;
  }

  // Internal constructor
  UserManager._internal();

  // User properties
  String? uid;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? phoneNumber;
  String? description;
  Position? location;

  // Method to populate user data
  void setUser({
    String? uid,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? phoneNumber,
    String? description,
  }) {
    this.uid = uid;
    this.username = username;
    this.email = email;
    this.firstName = firstName;
    this.lastName = lastName;
    this.dateOfBirth = dateOfBirth;
    this.phoneNumber = phoneNumber;
    this.description = description;
  }

  // Method to clear user data on sign out
  void clearUser() {
    uid = null;
    username = null;
    email = null;
    firstName = null;
    lastName = null;
    dateOfBirth = null;
    phoneNumber = null;
    description = null;
  }
}
