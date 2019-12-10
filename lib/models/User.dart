import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String profilePic;

  User({this.id, this.name, this.profilePic, this.email});

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      id: doc.documentID,
      email: doc["email"],
      name: doc["name"],
      profilePic: doc["profilePic"] ?? ""
    );
  }
}