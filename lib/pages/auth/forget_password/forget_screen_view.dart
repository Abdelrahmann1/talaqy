import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/extentions/padding_ext.dart';
import 'package:talaqy/pages/auth/forget_password/forget_view_model.dart';

import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/utils/app_router.dart';

import '../../../widgets/main_button.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => const ForgetView(),
      viewModel: ForgetViewModel(),
    );
  }
}

class ForgetView extends HookView<ForgetViewModel> {
  const ForgetView({super.key, reactive = true});

  @override
  Widget render(context, viewModel) {
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
            leading: const SizedBox(),
            title: Text(
              ' نسيت كلمة السر',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Column(


              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      "قم بإدخال البريد الإلكتروني",
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
                        keyboardType: TextInputType.emailAddress,
                        controller: viewModel.emailForgetPassword,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          labelText: 'البريد الالكتروني',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical:
                                  10), // Adjust the padding around the input field

                          labelStyle: Theme.of(context).textTheme.displaySmall,

                          alignLabelWithHint: true,

                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColors.greyForFileds),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: MainButton(
                        "إعادة تعيين الآن",
                        () {
                          viewModel.forgetPassword();

                        },
                        bgColor: AppColors.primaryColor,
                      ),
                    )
                  ],
                ),
              ],
            ).setPageHorizontalPadding(context),
          )),
    );
  }
}
