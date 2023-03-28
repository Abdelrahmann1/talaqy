import 'package:pmvvm/pmvvm.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:talaqy/utils/app_router.dart';

class SplashScreenViewModel extends ViewModel {
  Future<dynamic> delay() async{
    Future.delayed(const Duration(seconds: 1), () async {
      Navigator.pushNamed(context, AppRouter.onBoardingScreen);
    });}
  @override
  void init() {
    delay();
    super.init();
  }
}
