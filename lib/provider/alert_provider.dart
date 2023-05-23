import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
class AlertExitApp extends ChangeNotifier {

  Future<bool> alertExitApp(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: "title",
      desc: "desc",
      btnCancelOnPress: (){},
      btnOkOnPress: (){}).show();
    notifyListeners();
    return Future.value(true);
  }
}
