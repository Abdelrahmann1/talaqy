import 'package:flutter/widgets.dart';
import 'package:pmvvm/pmvvm.dart';
class LoginViewModel extends ViewModel {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
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


}
