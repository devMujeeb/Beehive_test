import 'package:beehive/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

void showToast(String msg, context) {
  FlutterToastr.show(
    msg,
    context,
    duration: 2,
    position: FlutterToastr.center,
    backgroundColor: themeColor,
    textStyle: TextStyle(
      color: whtColor,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
  );
}

bool isEmail(String mail) {
  bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
      .hasMatch(mail.trim());
  return emailValid;
}
