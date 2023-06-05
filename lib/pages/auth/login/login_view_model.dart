import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/utils/app_router.dart';
class LoginViewModel extends ViewModel {
  UserCredential? user;
  int? firstTime;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController passWord = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  bool? isChecked = false;
  bool loading = false;
  bool isShowPassword = true;
  String failureMassage = '';
  bool? isLogin=false;
  setCheckBoxValue(dynamic newBool) {
    isChecked = newBool;
    notifyListeners();
  }

  setLoading(bool bool) {
    loading = bool;
    notifyListeners();
  }

  showPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  signInWithEmailAndPassword() async {
    isLogin=true;
    notifyListeners();
    try {
     UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: passWord.text);
     final prefs = await SharedPreferences.getInstance();
     await prefs.setString('uidToken',userCredential.user!.uid );
     print(userCredential.user);

      Navigator.pushNamed(context, AppRouter.homeScreen);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          failureMassage = "الحساب غير موجود";
          break;
        case "invalid-email":
          failureMassage = "الحساب غير صالح";
          break;
        case "wrong-password":
          failureMassage = "الباسورد خطأ";
          break;
      }
      showDialog(context: context, builder: (context){
        return AlertDialog(
          backgroundColor: AppColors.white,
          title:const Center(child: Text("خطا في تسجيل الدخول ",style: TextStyle(fontSize: 12),)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(failureMassage,style: TextStyle(color: AppColors.blackColor),),
            ],
          ),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text("حسنا"))
          ],
        );
      });
    }
    finally {
      isLogin=false;
      notifyListeners();
    }
  }
}
// {required String email, required String password}) async {
// var formData = formKey.currentState;
// if (formData!.validate()) {
// showLoading(context);
// formData.save();
// } else {}
// try {
// showLoading(context);
// Navigator.of(context).pop();
//
// UserCredential userCredential = await FirebaseAuth.instance
//     .signInWithEmailAndPassword(email: email, password: password);
// return userCredential;
// } on FirebaseAuthException catch (e) {
// if (e.code == "user-not-found") {
// Navigator.of(context).pop();
// showDialog(
// context: context,
// builder: (context) {
// return const AlertDialog(
// title: Text("الحساب غير موجود"),
// );
// },
// );
// print("no user found");
// }
// else if (e.code == "wrong-password")
// {Navigator.of(context).pop();
// showDialog(
// context: context,
// builder: (context) {
// return const AlertDialog(title: Text("الباسورد خطأ"));
// },
// );
// }
// }
// }
