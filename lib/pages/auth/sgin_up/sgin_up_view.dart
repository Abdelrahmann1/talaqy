import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/extentions/padding_ext.dart';
import 'package:talaqy/pages/auth/sgin_up/sgin_up_view_model.dart';
import 'package:talaqy/provider/auth_provider.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/utils/app_router.dart';
import 'package:talaqy/widgets/small_button.dart';
import '../../../widgets/main_button.dart';
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => const RegisterView(),
      viewModel: SignUpViewModel(),
    );
  }
}
class RegisterView extends HookView<SignUpViewModel> {
  const RegisterView({super.key, reactive = true});

  @override
  Widget render(context, viewModel) {
    final userProviderAuth = Provider.of<UserProviderAuth>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            centerTitle: true,
            title: Text(
              'هيا نبدأ',
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
                        "أولاً, سنقوم الان بإنشاء حسابك",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.length > 100) {
                              return "لا يمكن ان يكون اسم المستخدم اكير من 100 حروف";
                            }
                            if (value.length < 3) {
                              return "لا يمكن ان يكون اسم المستخدم اقل من 3 حروف";
                            }
                            return null;
                          },
                          onSaved: (value){
                            viewModel.fullName =value;
                          },

                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            labelText: 'اسم المستخدم *',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical:
                                    10), // Adjust the padding around the input field

                            labelStyle:
                                Theme.of(context).textTheme.displaySmall,
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
                          onSaved: (value)
                          {
                            viewModel.email=value;
                          },
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
                                horizontal: 20,
                                vertical:
                                    10), // Adjust the padding around the input field

                            labelStyle:
                                Theme.of(context).textTheme.displaySmall,

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
                          onSaved: (value){
                            viewModel.passWord = value;
                          },
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
                          keyboardType: TextInputType.text,

                          decoration: InputDecoration(
                            labelText: ' كلمة السر',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical:
                                    10), // Adjust the padding around the input field

                            labelStyle:
                                Theme.of(context).textTheme.displaySmall,

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
                      // Directionality(
                      //   textDirection: TextDirection.rtl,
                      //   child: TextFormField(
                      //     obscureText: viewModel.isShowPassword,
                      //     textAlign: TextAlign.right,
                      //     autovalidateMode: AutovalidateMode.always,
                      //     decoration: InputDecoration(
                      //       suffixIcon: InkWell(
                      //         child: const Icon(Icons.remove_red_eye_outlined,
                      //             color: Colors.grey, size: 20),
                      //         onTap: () {
                      //           viewModel.showPassword();
                      //         },
                      //       ),
                      //       labelText: 'تأكيد كلمة السر',
                      //       contentPadding: const EdgeInsets.symmetric(
                      //           horizontal: 20,
                      //           vertical:
                      //               10), // Adjust the padding around the input field
                      //
                      //       labelStyle:
                      //           Theme.of(context).textTheme.displaySmall,
                      //       alignLabelWithHint: true,
                      //       border: OutlineInputBorder(
                      //         borderSide: const BorderSide(
                      //             color: AppColors.greyForFileds),
                      //         borderRadius: BorderRadius.circular(8.0),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 13,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "انا أوافق علي السياسات والخصوصية",
                            style: TextStyle(
                                fontSize: 10, color: AppColors.blackColor),
                          ),
                          Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: const BorderSide(
                                    width: 100, color: Colors.blue),
                              ),
                              value: viewModel.isChecked,
                              activeColor: AppColors.primaryColor,
                              onChanged: (value) {
                                viewModel.setCheckBoxValue(value);
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              height: 1.0,
                              width: 130.0,
                              color: AppColors.greyForFileds,
                            ),
                          ),
                          const Text(
                            "أو",
                            style: TextStyle(
                                color: AppColors.greyForFileds, fontSize: 10),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                                height: 1.0,
                                width: 130.0,
                                color: AppColors.greyForFileds),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SmallButton(
                              "Facebook", () {
                                print(viewModel.fullName);
                                print(viewModel.email);
                                print(viewModel.passWord);
                                }, FontAwesomeIcons.facebook),
                          SmallButton(
                            "Google",
                            () async{
                             await userProviderAuth.signInWithGoogle();

                            },
                            FontAwesomeIcons.google,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text("تسجيل الدخول",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackColor)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRouter.loginScreen);
                            },
                            child: Text(
                              "لديك حساب ؟ ",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          MainButton(
                            "إنشاء حساب",
                            ()  async{
                              viewModel.response = await viewModel.signUpWithEmailAndPassword(
                                   email: viewModel.email.toString(),
                                   password: viewModel.passWord.toString());
                              print(viewModel.response!.user!.email);
                              // if (viewModel.response !=null){
                              //   Navigator.pushReplacementNamed(context, AppRouter.homeScreen);
                              // }else{
                              //   print("sign in failed");
                              // }
                            },
                            bgColor: AppColors.primaryColor,
                          )
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
