import 'package:flutter/material.dart';
import 'package:talaqy/pages/auth/login/login_view.dart';
import 'package:talaqy/pages/home/home_view.dart';
import 'package:talaqy/pages/people_status/add_missing/edit_missing_view.dart';
import 'package:talaqy/pages/user_profile/user_profile_view.dart';

import '../pages/auth/forget_password/forget_screen_view.dart';
import '../pages/auth/sgin_up/sgin_up_view.dart';
import '../pages/child_profile/founded_child_profile/founded_child_profile_view.dart';
import '../pages/child_profile/missing_child_profile/missing_child_profile_view.dart';
import '../pages/onboarding_screen/onboarding_view.dart';
import '../pages/people_status/add_founded/add_founded_people_view.dart';
import '../pages/people_status/add_missing/add_missing_people_view.dart';
import '../pages/screen_messages/edit_is_successful.dart';
import '../pages/screen_messages/successful_message.dart';
import '../pages/splash_screen/splash_screen_view.dart';

class AppRouter{
  static const String splashScreen = "/SplashScreen";
  static const String onBoardingScreen = "/OnboardingScreen";
  static const String loginScreen = "/LoginScreen";
  static const String registerScreen = "/RegisterScreen";
  static const String forgetPasswordScreen = "/ForgetPasswordScreen";
  static const String homeScreen = "/HomeScreen";
  static const String addMissingScreen = "/AddMissingScreen";
  static const String addFoundedScreen = "/AddFoundedScreen";
  static const String successfulMessage = "/SuccessfulMessage";
  static const String editMissingScreen = "/EditMissingScreen";
  static const String successfulEditMessage = "/SuccessfulEditMessage";
  static const String userProfileScreen = "/UserProfileScreen";
  static const String missingChildProfileScreen = "/MissingChildProfileScreen";
  static const String foundedChildProfileScreen = "/FoundedChildProfileScreen";
  Map<String, WidgetBuilder> routes() {
    return {
      AppRouter.splashScreen: (context) =>  const SplashScreen(),
      AppRouter.onBoardingScreen: (context) =>  const OnBoardingScreen(),
      AppRouter.loginScreen: (context) =>  const LoginScreen(),
      AppRouter.registerScreen: (context) =>  const RegisterScreen(),
      AppRouter.forgetPasswordScreen: (context) =>  const ForgetScreen(),
      AppRouter.homeScreen: (context) =>  const HomeScreen(),
      AppRouter.addMissingScreen: (context) =>  const AddMissingPeople(),
      AppRouter.addFoundedScreen: (context) =>  const AddFoundedPeopleScreen(),
      AppRouter.successfulMessage: (context) =>  const SuccessfulMessage(),
      AppRouter.editMissingScreen: (context) =>   EditMissingScreen(),
      AppRouter.userProfileScreen: (context) =>   const UserProfileScreen(),
      AppRouter.successfulEditMessage: (context) =>  const SuccessfulEditMessage(),
      AppRouter.missingChildProfileScreen: (context) =>    MissingChildProfileScreen(),
      AppRouter.foundedChildProfileScreen: (context) =>    FoundedChildProfileScreen(),
    };
  }}
