import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
class AlertExitApp extends ChangeNotifier {

  Future<bool> alertExitApp(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: "هل انت متاكيد من الخروج",
      desc: "desc",
      btnCancelOnPress: (){},
      btnOkOnPress: (){Navigator.pop(context);}).show();
    notifyListeners();
    return Future.value(true);
  }
}
