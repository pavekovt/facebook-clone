import 'dart:io';

import 'package:facebook/services/Contants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static Future<String> uploadUserProfileImage(
    String userId,
    File imageFile,
  ) async {
    StorageUploadTask uploadTask = storageRef
        .child('images/users/userProfile_$userId.jpg')
        .putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }
}
