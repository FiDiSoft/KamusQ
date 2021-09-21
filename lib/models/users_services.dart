import 'package:cloud_firestore/cloud_firestore.dart';

class UsersServices {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static CollectionReference usersCollection =
      firebaseFirestore.collection('users');
}
