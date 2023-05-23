import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../../widgets/show_loading.dart';

class LoginViewModel extends ViewModel {



  UserCredential? user;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController passWord = TextEditingController();
  CollectionReference users =
  FirebaseFirestore.instance.collection("users");
  bool? isChecked = false;
  bool loading = false;
  bool isShowPassword = true;
  setCheckBoxValue(dynamic newBool) {
    isChecked = newBool;
    notifyListeners();
  }
  showPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  setLoading(bool bool) {
    loading = bool;
    notifyListeners();
  }

  signInWithEmailAndPassword(
      {required String email, required String password}) async {
    var formData = formKey.currentState;
    if (formData!.validate()) {
      showLoading(context);

      formData.save();
    } else {}
    try {
      showLoading(context);
      Navigator.of(context).pop();

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("الحساب غير موجود"),
            );
          },
        );
        print("no user found");
      }
      else if (e.code == "wrong-password")
      {Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(title: Text("الباسورد خطأ"));
          },
        );
      }
    }
  }
}
