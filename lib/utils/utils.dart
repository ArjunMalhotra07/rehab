import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rehab/utils/components/colors.dart';

class Utils {
  static toastMessage(String msg) {
    Fluttertoast.showToast(msg: msg, backgroundColor: Colors.lightGreen);
  }

  static void flushBarErrorMessage(String msg, BuildContext context,
      {Color? color}) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: msg,
          backgroundColor: color ?? Constants.redColor,
          // title: 'Warning!',
          duration: const Duration(seconds: 3),
          forwardAnimationCurve: Curves.easeInOut,
          flushbarPosition: FlushbarPosition.TOP,
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
        )..show(context));
  }

  static snackBar(String msg, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text(msg),
      duration: const Duration(seconds: 2),
    ));
  }
}
