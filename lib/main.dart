import 'package:flutter/material.dart';
import 'package:talaqy/pages/auth/login/login_view.dart';
import 'package:talaqy/pages/home/home_view.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/utils/app_router.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Alexandria",
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          displayMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,

          ),
          bodyMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            color: AppColors.white

          ),
          displaySmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
          )
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
      ),
      home: const
      HomeScreen(),
        routes: AppRouter().routes());
  }
}
