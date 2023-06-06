import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/utils/app_router.dart';
class UserProviderAuth extends ChangeNotifier {
  bool? isLogin = false;
  var loading = false;

  signOut(BuildContext context) {
    try {
      isLogin = true;
      notifyListeners();

      FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, AppRouter.loginScreen);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      return null;
    } finally {
      isLogin = false;
      notifyListeners();
    }
  }

   logInWithGoogle(BuildContext context) async {
    loading = true;
    notifyListeners();
    final googleSignIn = GoogleSignIn(scopes: ['email']);
    try {

      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignIn == null) {
        loading = false;
        notifyListeners();
        return;
      }
      final googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken,idToken: googleSignInAuthentication.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uidToken',FirebaseAuth.instance.currentUser!.uid );
      await FirebaseFirestore.instance.collection("users").add({
        'email': googleSignInAccount.email,
        'imageUrl': googleSignInAccount.photoUrl,
        'name': googleSignInAccount.email,
        'userId':  FirebaseAuth.instance.currentUser!.uid,
      });
      Navigator.pushReplacementNamed(context, AppRouter.homeScreen);
    } on FirebaseAuthException catch (e) {
      var content = '';
      switch (e.code) {
        case 'invalid-credential':
          content =
              'بيانات اعتماد المصادقة المقدمة غير صحيحة أو منتهية الصلاحية';
          break;
        case 'user-not-found':
          content = 'لم يتم العثور على المستخدم';
          break;
        case 'user-disabled':
          content = 'تعطيل المستخدم';
          break;
        case 'account-exists-with-different-credential':
          content = 'حساب موجود ببيانات اعتماد مختلفة';
          break;
        case 'operation-not-allowed':
          content = 'العملية غير مسموح بها';
          break;
      }
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  backgroundColor: AppColors.white,
                  title: const Center(
                      child: Text("نجاح الاشتراك",
                          style: TextStyle(fontSize: 12))),
                  content: SingleChildScrollView(
                      child: Text(
                    content,
                    style: const TextStyle(color: AppColors.blackColor),
                  )),
                  actions: [
                    TextButton (
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("حسنا"))
                  ]));
    }finally{
      loading = false;
      notifyListeners();
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
