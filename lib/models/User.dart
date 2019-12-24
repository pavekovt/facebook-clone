import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String email;
  String profileImageUrl;
  String city;
  List<String> friends;

  User({this.id, this.city, this.name, this.profileImageUrl, this.email, this.friends});

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      id: doc.documentID,
      email: doc["email"],
      name: doc["name"],
      city: doc["city"] ?? "",
      profileImageUrl: doc["profileImageUrl"] ?? ""
    );
  }
}