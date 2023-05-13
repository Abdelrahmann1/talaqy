import 'package:flutter/material.dart';
import 'package:talaqy/pages/auth/login/login_view.dart';
import 'package:talaqy/pages/home/home_view.dart';
import 'package:talaqy/pages/people_status/add_missing/edit_missing_view.dart';

import '../pages/auth/sgin_up/sgin_up_view.dart';
import '../pages/onboarding_screen/onboarding_view.dart';
import '../pages/people_status/add_missing/add_missing_people_view.dart';
import '../pages/screen_messages/successful_message.dart';
import '../pages/splash_screen/splash_screen_view.dart';

class AppRouter{
  static const String splashScreen = "/SplashScreen";
  static const String onBoardingScreen = "/OnboardingScreen";
  static const String loginScreen = "/LoginScreen";
  static const String registerScreen = "/RegisterScreen";
  static const String homeScreen = "/HomeScreen";
  static const String addMissingScreen = "/AddMissingScreen";
  static const String addFoundedScreen = "/AddFoundedScreen";
  static const String successfulMessage = "/SuccessfulMessage";
  static const String editMissingScreen = "/EditMissingScreen";
  static const String successfulEditMessage = "/SuccessfulEditMessage";
  Map<String, WidgetBuilder> routes() {
    return {
      AppRouter.splashScreen: (context) =>  const SplashScreen(),
      AppRouter.onBoardingScreen: (context) =>  const OnBoardingScreen(),
      AppRouter.loginScreen: (context) =>  const LoginScreen(),
      AppRouter.registerScreen: (context) =>  const RegisterScreen(),
      AppRouter.homeScreen: (context) =>  const HomeScreen(),
      AppRouter.addMissingScreen: (context) =>  const AddMissingPeople(),
      AppRouter.successfulMessage: (context) =>  const SuccessfulMessage(),
      AppRouter.editMissingScreen: (context) =>   EditMissingScreen(),
      AppRouter.successfulEditMessage: (context) =>   EditMissingScreen(),
    };
  }}
