import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/utils/app_router.dart';

class SignUpViewModel extends ViewModel {
  @override
  void init() {
    super.init();
    fbm.getToken().then((token) {
      tokenId = token;
      notifyListeners();
    });
  }

  UserCredential? response;
  bool? loading = false;
  bool? isCheckedPolicy = false;
  bool? isCheckedVolunteering = false;
  bool isShowPassword = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fullName = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController confirmPassWord = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController job = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  var fbm = FirebaseMessaging.instance;
  String? tokenId;

  setCheckBoxValuePolicy(dynamic newBool) {
    isCheckedPolicy = newBool;
    notifyListeners();
  }

  setCheckBoxValueVolunteering(dynamic newBool) {
    isCheckedVolunteering = newBool;
    notifyListeners();
  }

  showPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  String? requiredValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "هذا الحقل مطلوب";
    }
    return null;
  }

  String? confirmPasswordValidator(String? confirmPasswordText) {
    if (confirmPasswordText == null || confirmPasswordText.trim().isEmpty) {
      return "هذا الحقل مطلوب";
    }
    if (passWord.text != confirmPasswordText) {
      return 'كلمة المرور غير متطابقة';
    }
    return null;
  }
  void handelSignUpErrors(FirebaseAuthException e) {
    String messageToDisplay;
    switch (e.code) {
      case 'email-already-in-use':
        messageToDisplay =
            "عنوان البريد الإلكتروني قيد الاستخدام بالفعل من قبل حساب آخر";
        break;
      case 'invalid-email':
        messageToDisplay = "عنوان البريد الإلكتروني منسق بشكل سيئ";
        break;
      case 'operation-not-allowed':
        messageToDisplay = "العملية غير مسموح بها";
        break;
      case 'weak-password':
        messageToDisplay = "يجب أن تتكون كلمة المرور من 6 أحرف أو أكثر.";
        break;
      default:
        messageToDisplay = 'يوجد خطا ما';
        break;
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("فشل تسجيل الدخول"),
            content: Text(messageToDisplay),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("حسنا"))
            ],
          );
        });
  }
  signUpWithEmailAndPassword() async {
    loading = true;
    notifyListeners();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: passWord.text);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uidToken',FirebaseAuth.instance.currentUser!.uid );
      await FirebaseFirestore.instance
          .collection("users")
          .add({
            "name": fullName.text,
            "email": email.text,
            "PhoneNumber": phoneNumber.text,
            "jobOfUser": job.text,
            "imageUrl": "",
            "userId": FirebaseAuth.instance.currentUser!.uid,
            "VolunteeringStatus": isCheckedVolunteering,
            "IpTokenForMobileToSendNotifications ": tokenId
          })
          .then((value) => print('User data saved to Firestore'))
          .catchError((error) => print('Failed to save user data: $error'));
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  backgroundColor: AppColors.white,
                  title: const Center(
                      child: Text("نجاح الاشتراك",
                          style: TextStyle(fontSize: 12))),
                  content: const SingleChildScrollView(
                      child: Text(
                    "تم انشاء الحساب بي نجاح يمكنك الان الدخول",
                    style: TextStyle(color: AppColors.blackColor),textAlign: TextAlign.center,
                  )),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("حسنا"))
                  ]));
      Navigator.pushNamedAndRemoveUntil(context, AppRouter.homeScreen,(Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      handelSignUpErrors(e);
      loading = false;
      notifyListeners();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
