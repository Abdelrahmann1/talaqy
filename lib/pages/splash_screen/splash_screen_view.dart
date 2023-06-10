import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/extentions/padding_ext.dart';
import 'package:talaqy/pages/splash_screen/splash_screen_view_model.dart';
import 'package:talaqy/utils/app_colors.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => const SplashView(),
      viewModel: SplashScreenViewModel(),
    );
  }
}
class SplashView extends HookView<SplashScreenViewModel> {
  const SplashView({Key? key, reactive = true});
  @override
  Widget render(context, viewModel) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(child: Image.asset('assets/images/logo.png', scale: 3.2)
      ).setPageHorizontalPadding(context)
    );
  }
}
