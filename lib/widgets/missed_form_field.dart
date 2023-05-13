import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
class MainFormField extends StatelessWidget {
  final  TextEditingController controller;
  final TextInputType? textInputType;
  final  String labelText ;
  final String? Function(String?)? validator;
  const MainFormField({Key? key, required this.controller, this.validator, required this.labelText, this.textInputType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        validator:validator,
        controller: controller,
        textAlign: TextAlign.right,
        keyboardType:textInputType,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10), // Adjust the padding around the input field
          labelStyle: Theme.of(context).textTheme.displaySmall,
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderSide:  const BorderSide(color: AppColors.greyForFileds),
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
    );
  }
}