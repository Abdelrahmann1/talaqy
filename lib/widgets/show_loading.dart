import 'package:flutter/material.dart';

showLoading(context) {
  return
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: AlertDialog(
            title: Center(child: Text("برجاء الانتظار")),
            content: SizedBox(
              height: 50,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      });
}
