import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
class MainFormField extends StatelessWidget {
  final String? initialValue;
  final readonly;
  final  TextEditingController controller;
  final TextInputType? textInputType;
  final  String labelText ;
    String? hintText ;
  final Function? onTap;
  final String? Function(String?)? validator;
   MainFormField({Key? key, this.hintText,required this.controller,this.onTap, this.validator,this.initialValue, required this.labelText, this.textInputType, this.readonly,   }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        onTap:onTap as void Function()? ,
        initialValue:initialValue,
        validator:validator,
        controller: controller,
        readOnly: readonly ?? false,
        textAlign: TextAlign.right,
        keyboardType:textInputType,
        decoration: InputDecoration(
          hintText:hintText,
          labelText: labelText,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10),
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
