import 'package:flutter/material.dart';
import 'package:talaqy/utils/app_colors.dart';

class NotFound extends StatelessWidget {
  final String status;
  final String imageAssets;
  const NotFound({Key? key, required this.status, required this.imageAssets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
            children:[
               Text(
                 status,
                style: const TextStyle(
                  fontSize: 22,
                  color: AppColors.blackColor,
                ),
              ),const SizedBox(height: 20,),
              Center(
                child: Image.asset(
                  imageAssets,
                  width: double.infinity,

                ),
              )])
      ],
    );
  }
}
