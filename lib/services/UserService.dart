import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/models/User.dart';
import 'package:facebook/services/Contants.dart';

class UserService {

  static Future<User> getUserById(String id) async {
    DocumentSnapshot userSnap = await usersRef.document(id).get();
    if (userSnap.exists) {
      return User.fromDoc(userSnap);
    }

    return User();
  }

  static Future updateUser(User user) async {
    await usersRef.document(user.id).updateData({
      'name': user.name,
      'profileImageUrl': user.profileImageUrl,
      'city': user.city
    });
  }

  static Future<QuerySnapshot> streamForUsers(String name) async {
    return await usersRef.where('name', isGreaterThan: name).getDocuments();
  }
}