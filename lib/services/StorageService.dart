import 'dart:io';

import 'package:facebook/services/Contants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static Future<String> uploadUserProfileImage(
      String url, File imageFile) async {
    String photoId = Uuid().v4();

    if (url.isNotEmpty) {
      // Updating user profile image
      RegExp exp = RegExp(r'userProfile_(.*).jpg');
      photoId = exp.firstMatch(url)[1];
    }

    StorageUploadTask uploadTask = storageRef
        .child('images/users/userProfile_$photoId.jpg')
        .putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }
}
