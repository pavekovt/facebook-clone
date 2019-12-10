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

}