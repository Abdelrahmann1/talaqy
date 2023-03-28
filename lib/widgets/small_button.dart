import 'package:flutter/material.dart';
import 'package:talaqy/utils/app_colors.dart';
class SmallButton extends StatelessWidget {
   SmallButton(this.signIn, this.onTap,this.icons, {super.key, this.bgColor});
  String? signIn;
  IconData? icons;
  final Color? bgColor;
  final Function onTap;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          border: Border.all(color: AppColors.greyForFileds)
        ),
        width: 115,
        height: 48,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Icon(icons!, color: Colors.blue, size: 22.0),
            Text(
              signIn!,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, color: AppColors.facebook),
            ),
          ],
        ),
      ),
    );
  }
}
