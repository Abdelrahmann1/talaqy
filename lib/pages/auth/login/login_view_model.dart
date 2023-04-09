import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pmvvm/pmvvm.dart';

class LoginViewModel extends ViewModel {
  UserCredential? user;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var  passWord, email;
  bool? isChecked = false;
  bool isShowPassword = true;
  setCheckBoxValue(dynamic newBool) {
    isChecked = newBool;
    notifyListeners();
  }
  showPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }
  signInWithEmailAndPassword(
      {required String email, required String password}) async {
    var formData = formKey.currentState;
    if (formData!.validate()) {
      formData.save();
    } else {
      print("Not Valid");
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("الحساب غير موجود"),
            );
          },
        );
        print("no user found");
      } else if (e.code == "wrong-password") {
        {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("الباسورد خطأ"),
              );
            },
         );

        }
      }
    }
  }
}
