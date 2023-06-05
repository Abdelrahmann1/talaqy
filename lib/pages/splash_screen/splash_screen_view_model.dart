import 'package:pmvvm/pmvvm.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talaqy/utils/app_router.dart';
class SplashScreenViewModel extends ViewModel {
  Future<dynamic> delay() async {
    Future.delayed(const Duration(seconds: 1), () async {});
     final prefs = await SharedPreferences.getInstance();
    final String? uidTokenFromUser = prefs.getString('uidToken');
    if (uidTokenFromUser == null){
      Navigator.pushReplacementNamed(context, AppRouter.loginScreen);
    }else{
      Navigator.pushReplacementNamed(context, AppRouter.homeScreen);
    }
  }
  @override
  void init() {
    super.init();
    delay();
  }
}
