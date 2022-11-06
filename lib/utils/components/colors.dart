import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Constants {
  static const Color blackColor = Colors.black;

  static const Color blackShade = Colors.black54;

  static const Color blackShade1 = Colors.black45;

  static const Color whiteColor = Colors.white;

  static const Color blueColor = Colors.blue;

  static const Color greenColor = Colors.green;

  static const Color redColor = Colors.red;

  static const Color greyColor = Colors.grey;

  static Color lightGreyColor = Colors.grey.shade300;

  final user = FirebaseAuth.instance.currentUser;

  String userId() {
    var uid = user?.uid;
    return uid.toString();
  }
}
