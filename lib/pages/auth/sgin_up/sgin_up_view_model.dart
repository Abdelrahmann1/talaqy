import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
class SignUpViewModel extends ViewModel {
  UserCredential? response;
  bool? isChecked = false;
  bool isShowPassword = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var fullName, passWord, email;
  setCheckBoxValue(dynamic newBool) {
    isChecked = newBool;
    notifyListeners();
  }
  showPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }
  signUpWithEmailAndPassword({required String email, required String password}) async {
    var formData = formKey.currentState;
    if (formData!.validate()) {
      formData.save();
    } else {
      print("Not Valid");
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("الباسورد ضعيف"),
            );
          },
        );
      } else if (e.code == "email-already-in-use") {
        {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("الايميل موجود بالفعل"),
              );
            },
          );
        }
      }
    }
  }
}
