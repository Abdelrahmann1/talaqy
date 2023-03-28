import 'package:flutter/material.dart';
import 'package:talaqy/utils/app_colors.dart';
class MainButton extends StatelessWidget {
  final String? text;
  final Function onTap;
  final Color? bgColor;
  final Color? textColor;
  const MainButton(this.text, this.onTap, {super.key, this.bgColor, this.textColor});
  @override
  Widget build(BuildContext context) {
    return
     Container(
       width: MediaQuery.of(context).size.width/1.2,
       height: 45,
       child: ElevatedButton(
         style: ElevatedButton.styleFrom(
           backgroundColor: bgColor
         ),

           onPressed: onTap as void Function()?, child: Text(text!,style: Theme.of(context).textTheme.bodyMedium,)),
     );

  }
}
