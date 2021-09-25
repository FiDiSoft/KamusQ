import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User?> login(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
      return null;
    }
  }

  static Future<User?> register(
      {required String username,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      await user!.updateDisplayName(username);

      //TODO:  remove the comment if need verif email
      // if (user != null && !user.emailVerified) {
      //   await user.sendEmailVerification();
      // }

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
      return null;
    }
  }

  static Future<void> logOut() async => await auth.signOut();

  static Stream<User?> get userStream => auth.authStateChanges();
}
