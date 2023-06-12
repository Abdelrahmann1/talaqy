import 'package:flutter/material.dart';
import 'package:talaqy/extentions/padding_ext.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/utils/app_router.dart';
import 'package:talaqy/widgets/main_button.dart';

class SuccessfulMessage extends StatelessWidget {
  const SuccessfulMessage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.white,
            body: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(itemBuilder: (context, i) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0, left: 8),
                            child: Text(
                              "تم الإبلاغ عن الطفل بنجاح",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Image.asset(
                            "assets/images/successful.png",
                            height: 250,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                    );
                  }),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35)),
                            margin: const EdgeInsets.only(bottom: 40),
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: MainButton(
                                "الصفحة الرئيسية",
                                () {
                                  Navigator.of(context).pop();
                                  Navigator.pushNamedAndRemoveUntil(context, AppRouter.homeScreen,(Route<dynamic> route) => false);
                                  },
                                bgColor: AppColors.primaryColor,
                              ),
                            )),
                      ],
                    ).setPageHorizontalPadding(context)
                  ],
                )),
              ],
            )));
  }
}
