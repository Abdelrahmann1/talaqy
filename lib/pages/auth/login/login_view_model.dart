import 'package:pmvvm/pmvvm.dart';
class LoginViewModel extends ViewModel {
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
