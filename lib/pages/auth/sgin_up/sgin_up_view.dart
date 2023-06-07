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
import '../../../widgets/missed_form_field.dart';

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
            centerTitle: true,
            title: Text(
              'هيا نبدأ',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            leading: const SizedBox(),
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
                          validator: viewModel.requiredValidator,
                          controller: viewModel.fullName,
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
                          controller: viewModel.email,
                          validator: viewModel.requiredValidator,
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
                          controller: viewModel.passWord,
                          validator: viewModel.requiredValidator,
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
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: viewModel.confirmPassWord,
                          validator: viewModel.confirmPasswordValidator,
                          obscureText: viewModel.isShowPassword,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'تاكيد كلمة السر',
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
                      MainFormField(
                        textInputType: TextInputType.number,
                        controller: viewModel.phoneNumber,
                        labelText: 'رقم تليفون ',
                        validator: (value) {
                          if (value!.length > 11) {
                            return "لا يمكن ان يكون اكثر من 11 رقم";
                          }
                          if (value.length < 0) {
                            return "لا يمكن ان يكون اقل من 3 حرف";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: viewModel.job,
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
                            labelText: 'المهنة',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                              value: viewModel.isCheckedPolicy,
                              activeColor: AppColors.primaryColor,
                              onChanged: (value) {
                                viewModel.setCheckBoxValuePolicy(value);
                              }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "هل انت علي استعداد التطوع ؟",
                            style: TextStyle(
                                fontSize: 10, color: AppColors.blackColor),
                          ),
                          Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: const BorderSide(
                                    width: 100, color: Colors.blue),
                              ),
                              value: viewModel.isCheckedVolunteering,
                              activeColor: AppColors.primaryColor,
                              onChanged: (value) {
                                viewModel.setCheckBoxValueVolunteering(value);
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SmallButton(
                          //     "Facebook", () {}, FontAwesomeIcons.facebook),
                          SmallButton(
                            "Google",
                            () async {
                              await userProviderAuth.logInWithGoogle(context);
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
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRouter.loginScreen);
                            },
                            child: const Text("تسجيل الدخول",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackColor)),
                          ),
                          Text(
                            "لديك حساب ؟ ",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MainButton("إنشاء حساب",
                              () async {if (viewModel.formKey.currentState != null && viewModel.formKey.currentState!.validate()) {viewModel.signUpWithEmailAndPassword();}},
                              bgColor: AppColors.primaryColor,
                            ),
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
