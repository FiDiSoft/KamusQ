import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:kamusq/models/auth_services.dart';
import 'package:path/path.dart';

class PhotoUrlServices {
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  static Future<void> updateUrl(String imagePath, File imageFile) async {
    String filename = basename(imagePath);
    try {
      TaskSnapshot taskSnapshot = await firebaseStorage
          .ref()
          .child('users')
          .child(AuthServices.auth.currentUser!.uid)
          .child(filename)
          .putFile(imageFile);
      await taskSnapshot.ref.getDownloadURL().then(
          (value) => AuthServices.auth.currentUser!.updatePhotoURL(value));
    } catch (e) {
      print(e.toString());
    }
  }
}
