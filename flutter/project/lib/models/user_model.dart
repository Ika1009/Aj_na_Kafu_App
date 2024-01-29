class Location {
  final double latitude;
  final double longitude;
  final double accuracy;
  final String timestamp;

  Location({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.timestamp,
  });

  // Method to convert the Location object to a Map, if needed to store back in Firestore
  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
      'timestamp': timestamp,
    };
  }
}

class UserModel {
  String email, username, firstName, lastName, dateOfBirth, phoneNumber, description, uid, imageUrl;
  bool status;
  List<String> friends, sentRequests, receivedRequests;
  Location? location;

    // Konstruktor za koriscenje podataka korisnika koji su vec u bazi za pristup njihovim podacima
    UserModel({
      required this.email,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.dateOfBirth,
      required this.phoneNumber,
      required this.description,
      required this.uid,
      required this.imageUrl,
      required this.friends,
      required this.sentRequests,
      required this.receivedRequests,
      this.status = false,
      this.location,
    });

  // If you need to create UserModel from a Map (e.g., from Firestore), you might have a factory constructor like this:
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      description: map['description'] ?? '',
      uid: map['uid'] ?? '',
      imageUrl: map['imageUrl'] ?? 'https://bonanza.mycpanel.rs/ajnakafu/images/profile_basic.png',
      friends: List<String>.from(map['friends'] ?? []),
      sentRequests: List<String>.from(map['sentRequests'] ?? []),
      receivedRequests: List<String>.from(map['receivedRequests'] ?? []),
      status: map['status'] ?? false,
      location: map['location'] != null ? Location(
        latitude: map['location']['latitude'] ?? 0.0,
        longitude: map['location']['longitude'] ?? 0.0,
        accuracy: map['location']['accuracy'] ?? 0.0,
        timestamp: map['location']['timestamp'] ?? '',
      ) : null,
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'phoneNumber': phoneNumber,
      'description': description,
      'uid': uid,
      'imageUrl': imageUrl,
      'friends': friends,
      'sentRequests': sentRequests,
      'receivedRequests': receivedRequests,
      'status': status,
      'location': location?.toMap(),
    };
  }
}
