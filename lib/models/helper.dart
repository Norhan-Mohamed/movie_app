import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void alertDialog(BuildContext context, String msg) {
  Fluttertoast.showToast(msg: msg);
}

bool validateEmail(String email) {
  final emailReg = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );
  return emailReg.hasMatch(email);
}
