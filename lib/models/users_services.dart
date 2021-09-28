import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UsersServices {
  final File file;

  UsersServices(this.file);

  Future<String?> uploadFile(String filePath) async {
    try {
      var _uploadFile = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users$file')
          .putFile(file);
      var getURL = await _uploadFile.ref.getDownloadURL();
      String url = getURL.toString();

      return url;
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      return 'hallo';
    }
  }
}
