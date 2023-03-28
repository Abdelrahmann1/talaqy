import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
class SignUpViewModel extends ViewModel {
  bool? isChecked = false;
  bool isShowPassword = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fullName = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController email = TextEditingController();
  setCheckBoxValue(dynamic newBool) {
    isChecked = newBool;
    notifyListeners();
  }
  showPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

}
