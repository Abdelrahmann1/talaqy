import 'package:firebase_auth/firebase_auth.dart';
import 'package:pmvvm/pmvvm.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:talaqy/pages/auth/login/login_view.dart';
import 'package:talaqy/pages/home/home_view.dart';

class SplashScreenViewModel extends ViewModel {
  Future<dynamic> delay() async {
    Future.delayed(const Duration(seconds: 1), () async {});
    await checkUser();
  }
  @override
  void init() {
    super.init();
    delay();
  }
  checkUser() async {
    StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}
