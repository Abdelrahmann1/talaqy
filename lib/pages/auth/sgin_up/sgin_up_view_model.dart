import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SignUpViewModel extends ViewModel {
  bool? isChecked = false;
  bool isShowPassword = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // TextEditingController fullName = TextEditingController();
  // TextEditingController passWord = TextEditingController();
  // TextEditingController email = TextEditingController();
  var fullName, passWord, email;
  setCheckBoxValue(dynamic newBool) {
    isChecked = newBool;
    notifyListeners();
  }

  showPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    var formData = formKey.currentState;
    if (formData!.validate()) {
      formData.save();
    } else {
      print("Not Valid");
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        AwesomeDialog(
            context: context,
            title: 'Error ',
            body: const Text("Password Is To Weak"));
        print("the password weak");
      } else if (e.code == "email-already-in-use") {
        {
          AwesomeDialog(
              context: context,
              title: 'Error ',
              body: const Text("Acc already in use"));

          print("Acc already in use");
        }
      }
    }
  }
}
