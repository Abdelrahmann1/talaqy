import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';

class SignUpViewModel extends ViewModel {
  @override
  void init() {
    super.init();
    fbm.getToken().then((token) {
      tokenId =token;
      notifyListeners();
    });

  }
  UserCredential? response;
  bool? isChecked = false;
  bool isShowPassword = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fullName = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  var fbm = FirebaseMessaging.instance;
  String? tokenId;

  setCheckBoxValue(dynamic newBool) {
    isChecked = newBool;
    notifyListeners();
  }
  showPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }
  void addUserToFireStore()async{
    FirebaseFirestore.instance.collection("users").add({
      "userName":fullName.text,
      "email":email.text,
      "PhoneNumber":phoneNumber.text,
      "IpTokenForMobileToSendNotifications ":tokenId,

    })
        .then((value) => print('User data saved to Firestore'))
        .catchError((error) => print('Failed to save user data: $error'));

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
