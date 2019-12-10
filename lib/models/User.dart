import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String email;
  String profileImageUrl;
  String city;

  User({this.id, this.city, this.name, this.profileImageUrl, this.email});

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