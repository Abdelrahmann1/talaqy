import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talaqy/pages/onboarding_screen/onboarding_view.dart';
import 'package:talaqy/pages/people_status/add_missing/add_missing_people_view_model.dart';
import 'package:talaqy/pages/splash_screen/splash_screen_view.dart';
import 'package:talaqy/provider/auth_provider.dart';
import 'package:talaqy/provider/search_bar%20provider.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/utils/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'provider/alert_provider.dart';

int? initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProviderAuth>(
              create: (context) => UserProviderAuth()),
          ChangeNotifierProvider<AlertExitApp>(
              create: (context) => AlertExitApp()),
          ChangeNotifierProvider<SearchBarProvider>(
              create: (context) => SearchBarProvider()),
          ChangeNotifierProvider<AddMissingPeopleViewModel>(
              create: (context) => AddMissingPeopleViewModel())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: "Alexandria",
                textTheme: const TextTheme(
                    displayLarge: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),
                    displayMedium:TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    bodyMedium: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.white),
                    displaySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    titleSmall:TextStyle(fontSize: 10, fontWeight: FontWeight.w400)),
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
                useMaterial3: true),
            home: initScreen == 0 || initScreen == null
                ? const OnBoardingScreen()
                : const SplashScreen(),routes: AppRouter().routes()));
  }
}
