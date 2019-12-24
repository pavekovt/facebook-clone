import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/models/User.dart';
import 'package:facebook/services/Contants.dart';

class UserService {

  static Future<User> getUserById(String id) async {
    DocumentSnapshot userSnap = await usersRef.document(id).get();
    if (userSnap.exists) {
      var friends = await userFriends(id);
      var user = User.fromDoc(userSnap);

      user.friends = friends.map((f) => f.documentID).toList();

      return user;
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

  static Future<List<DocumentSnapshot>> userFriends(String userId) async {
    var querySnapshot = usersRef.document(userId).collection(friendCollection);
    return (await querySnapshot.getDocuments()).documents;
  }
}