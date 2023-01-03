import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthHelpers {
  FirebaseAuthHelpers._();
  static final FirebaseAuthHelpers firebaseAuthHelpers =
      FirebaseAuthHelpers._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> sigupuser(
      {required String email, required String password}) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<User?> signInUser(
      {required String email, required String password}) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
