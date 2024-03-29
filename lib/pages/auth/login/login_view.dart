import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/extentions/padding_ext.dart';
import 'package:talaqy/pages/auth/login/login_view_model.dart';
import 'package:talaqy/provider/auth_provider.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/widgets/small_button.dart';

import '../../../utils/app_router.dart';
import '../../../widgets/main_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => const LoginView(),
      viewModel: LoginViewModel(),
    );
  }
}

class LoginView extends HookView<LoginViewModel> {
  const LoginView({super.key, reactive = true});
  @override
  Widget render(context, viewModel) {
    final userProviderAuth = Provider.of<UserProviderAuth>(context);
    return SafeArea(

      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const SizedBox(),
            centerTitle: true,
            title: Text(
              'مرحبا بك',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Text(
                        "قم بإدخال البريد الالكتروني وكلمة السر",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 13,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: viewModel.email,
                          validator: (value) {
                            if (value!.length > 100) {
                              return "لا يمكن ان يكون اكثر من 100 حرف";
                            }
                            if (value.length < 3) {
                              return "لا يمكن ان يكون اقل من 3 حرف";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            labelText: 'البريد الالكتروني',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            labelStyle: Theme.of(context).textTheme.displaySmall,
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.greyForFileds),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: viewModel.passWord,
                          validator: (value) {
                            if (value!.length > 50) {
                              return "لا يمكن ان يكون كلمه المرور اكير من 100 حرف";
                            }
                            if (value.length < 6) {
                              return "لا يمكن ان يكون كلمة السر اقل من 6 حرف";
                            }
                            return null;
                          },
                          obscureText: viewModel.isShowPassword,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            labelText: ' كلمة السر',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical:
                                    10), // Adjust the padding around the input field

                            labelStyle: Theme.of(context).textTheme.displaySmall,

                            alignLabelWithHint: true,
                            suffixIcon: InkWell(
                              child: const Icon(Icons.remove_red_eye_outlined,
                                  color: Colors.grey, size: 20),
                              onTap: () {
                                viewModel.showPassword();
                              },
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.greyForFileds),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                               Navigator.pushNamed(context, AppRouter.forgetPasswordScreen);
                              },
                              child: const Text(
                                "نسيت كلمة السر ؟",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 10),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                height: 1.0,
                                width: 130.0,
                                color: AppColors.greyForFileds,
                              ),
                            ),
                          ),
                          const Text(
                            "أو",
                            style: TextStyle(
                                color: AppColors.greyForFileds, fontSize: 10),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                  height: 1.0,
                                  width: 130.0,
                                  color: AppColors.greyForFileds),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(!userProviderAuth.loading!)
                            SmallButton(
                            "Google",
                            () async {
                                  await userProviderAuth.logInWithGoogle(context);
                            },
                            FontAwesomeIcons.google,
                          ),
                          if(userProviderAuth.loading!)
                            const Center(child: CircularProgressIndicator(),)

                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRouter.registerScreen);
                            },
                            child: const Text(" إنشاء حساب جديد",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackColor)),
                          ),
                          Text(
                            "لا تملك حساب ؟ ",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(

                        children: [
                          if(!viewModel.isLogin!)
                            MainButton(
                            "تسجيل الدخول",
                            () async {
                              viewModel.user =
                                  await viewModel.signInWithEmailAndPassword();
                            },
                            bgColor: AppColors.primaryColor,
                          ),
                          if(viewModel.isLogin!)
                            MainButton(
                              "جاري تسجيل الدخول",
                                  () async {},
                              bgColor: AppColors.blackColor,
                            ),

                        ],
                      )
                    ],
                  ),
                ],
              ).setPageHorizontalPadding(context),
            ),
          )),
    );
  }
}
