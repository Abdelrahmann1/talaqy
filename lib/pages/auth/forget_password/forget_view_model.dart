import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/utils/app_colors.dart';

class ForgetViewModel extends ViewModel {
  TextEditingController emailForgetPassword = TextEditingController();
  String failureMassage = '';

  @override
  void dispose() {
    emailForgetPassword.dispose();
    super.dispose();
  }

  void forgetPassword() async {
    if (emailForgetPassword.text.isEmpty ||
        !emailForgetPassword.text.contains("@")) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("حسنا"),
                )
              ],
              content: const Text(
                "يرجى إدخال عنوان البريد الإلكتروني الصحيح",
                style: TextStyle(color: AppColors.blackColor, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              title: const Text("حدث خطأ",
                  style: TextStyle(color: AppColors.blackColor, fontSize: 14),
                  textAlign: TextAlign.center),
            );
          });
    } else {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailForgetPassword.text);
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "invalid-email":
            failureMassage = "بريد إلكتروني خاطئ";
            break;
          case "user-not-found":
            failureMassage = "لم يتم العثور على المستخدم";
            break;
          case "too-many-requests":
            failureMassage = "طلبات كثيرة جدا";
            break;
        }
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: AppColors.white,
                title: const Center(
                    child: Text(
                  "خطا في تسجيل الدخول ",
                  style: TextStyle(fontSize: 12),
                )),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      failureMassage,
                      style: const TextStyle(color: AppColors.blackColor),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("حسنا"))
                ],
              );
            });
      } catch (e) {
        print('Failed to send password reset email: $e');
      }
    }
  }
}
