import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:talaqy/pages/home/home_view.dart';
import 'package:talaqy/pages/onboarding_screen/onboarding_view.dart';
import 'package:talaqy/provider/auth_provider.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/utils/app_router.dart';
import 'package:firebase_core/firebase_core.dart';

import 'provider/alert_provider.dart';

void main() async {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(channelKey: 'channelKey', channelName: 'channelName', channelDescription: 'channelDescription')
  ]);
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  WidgetsFlutterBinding.ensureInitialized();
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
        ],
        child: MaterialApp(
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
                    color: AppColors.white),
                displaySmall: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                titleSmall: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
              useMaterial3: true,
            ),
            home: StreamBuilder(
                stream: FirebaseAuth.instance.userChanges(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return const HomeScreen();
                  } else {
                    return const OnBoardingScreen();
                  }
                }),
            routes: AppRouter().routes()));
  }
}
