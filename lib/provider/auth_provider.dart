import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class UserProviderAuth extends ChangeNotifier {
  Future<void> signUpWithEmailAndPassword({required String email,required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email:email,
          password: password
      );
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        print("the password weak");
      } else if (e.code == "email-already-in-use") {
        {
          print("Acc already in use");
        }
      }
    }
  }
  Future<void> signInWithEmailAndPassword({required String email,required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email:email,
          password: password
      );
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("no user found");
      } else if (e.code == "wrong-password") {
        {
          print("wrong password");
        }
      }
    }
  }
  signOut() {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }
  Future<UserCredential> signInWithGoogle() async {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
}
