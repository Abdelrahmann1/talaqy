import 'package:flutter/material.dart';
import 'package:talaqy/pages/auth/login/login_view.dart';
import 'package:talaqy/pages/home/home_view.dart';

import '../pages/auth/sgin_up/sgin_up_view.dart';
import '../pages/onboarding_screen/onboarding_view.dart';
import '../pages/splash_screen/splash_screen_view.dart';

class AppRouter{
  static const String splashScreen = "/SplashScreen";
  static const String onBoardingScreen = "/OnboardingScreen";
  static const String loginScreen = "/LoginScreen";
  static const String registerScreen = "/RegisterScreen";
  static const String homeScreen = "/HomeScreen";
  Map<String, WidgetBuilder> routes() {
    return {
      AppRouter.splashScreen: (context) =>  const SplashScreen(),
      AppRouter.onBoardingScreen: (context) =>  const OnBoardingScreen(),
      AppRouter.loginScreen: (context) =>  const LoginScreen(),
      AppRouter.registerScreen: (context) =>  const RegisterScreen(),
      AppRouter.homeScreen: (context) =>  const HomeScreen(),
    };
  }}
