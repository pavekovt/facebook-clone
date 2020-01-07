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
    return await usersRef.orderBy('name').startAt([name]).endAt([name + '\uf8ff']).getDocuments();
  }

  static Future<List<DocumentSnapshot>> userFriends(String userId) async {
    var querySnapshot = usersRef.document(userId).collection(friendCollection);
    return (await querySnapshot.getDocuments()).documents;
  }

  static Future inviteOrAcceptFriend(String currentUserId, String userId) async {
    var userInviteRef = usersRef.document(currentUserId)
          .collection(frinedInviteCollection)
          .document(userId);

    var userInviteExists = await userInviteRef 
          .get()
          .then((value) => value.exists);

    // Accepting invite of this user
    if (userInviteExists) {
      userInviteRef.delete();
      return addFriend(currentUserId, userId);
    }

    //Inviting user to be friend
    usersRef.document(userId).collection(frinedInviteCollection).document(currentUserId).setData({});
  }

  static Future addFriend(String currentUserId, String userId) async {
    return Future.wait([
      usersRef.document(currentUserId).collection(friendCollection).document(userId).setData({}),
      usersRef.document(userId).collection(friendCollection).document(currentUserId).setData({}),
    ]);
  }

  static Future removeFriend(String currentUserId, String userId) async {
    return Future.wait([
      usersRef.document(currentUserId).collection(friendCollection).document(userId).delete(),
      usersRef.document(userId).collection(friendCollection).document(currentUserId).delete(),
    ]);
  }
}