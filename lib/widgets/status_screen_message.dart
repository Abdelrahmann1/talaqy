import 'package:flutter/material.dart';
import 'package:talaqy/utils/app_colors.dart';
class StatusMessage extends StatelessWidget {
  final String statusOfMassage;
  final String statusImage;
  final String textButton;
  final Function onTap;
  final Color? bgColor;

  const StatusMessage(
      {Key? key,
      required this.statusOfMassage,
      required this.statusImage,
      required this.textButton,
      required this.onTap,
      this.bgColor})
      : super(key: key);
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
                    return Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8),
                          child: Text(
                            statusOfMassage,
                            style: const TextStyle(
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
                          statusImage,
                          height: 250,
                          fit: BoxFit.contain,
                        )
                      ],
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
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 45,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: bgColor),
                                  onPressed: onTap as void Function()?,
                                  child: Text(
                                    textButton,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )),
                            ))
                      ],
                    ),
                  ],
                )),
              ],
            )));
  }
}
// Navigator.of(context).pop();
// Navigator.pushReplacementNamed(context, AppRouter.homeScreen);
