import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rehab/utils/components/colors.dart';
import 'package:rehab/utils/utils.dart';

import '../utils/routes/routes_name.dart';

class FirebaseCalls {
  var firebaseObject = FirebaseAuth.instance;

  Future signUp(String email, pass, BuildContext context) async {
    try {
      await firebaseObject
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((value) {
        if (kDebugMode) {
          print("Id ${value.user?.email}");
        }

        Timer(const Duration(seconds: 1), () {
          Navigator.popAndPushNamed(context, RoutesName.practice);
        });
        Utils.flushBarErrorMessage("Sign Up Successful", context,
            color: AppColors.greenColor);
      }).catchError((error, stackTrace) {
        if (kDebugMode) {
          print("error");
          print(error.message);
        }
        Utils.flushBarErrorMessage(error.message.toString(), context,
            color: AppColors.redColor);
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }

      Utils.flushBarErrorMessage("Error Signing in ... ", context,
          color: AppColors.redColor);
    }
  }

  Future signIn(String email, pass, BuildContext context) async {
    try {
      await firebaseObject
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((value) {
        if (kDebugMode) {
          print("Id $value");
        }
        Timer(const Duration(seconds: 1), () {
          Navigator.popAndPushNamed(context, RoutesName.practice);
        });
        Utils.flushBarErrorMessage("Login Successful", context,
            color: AppColors.blueColor);
      }).catchError((error, stackTrace) {
        if (kDebugMode) {
          print("Error");
          print(error.message);
        }
        Utils.flushBarErrorMessage(error.message.toString(), context,
            color: AppColors.redColor);
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Firebase Auth Exception Login");
        print(e.message);
      }

      Utils.flushBarErrorMessage("Error Logging In ... ", context,
          color: AppColors.redColor);
    }
  }

  Future signOut(BuildContext context) async {
    try {
      firebaseObject.signOut().then((value) {
        Timer(const Duration(seconds: 1), () {
          Navigator.popAndPushNamed(context, RoutesName.login);
        });
        Utils.flushBarErrorMessage("Logged out successfully ", context,
            color: AppColors.blueColor);
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Firebase Auth Exception Logout");
        print(e.message);
      }
      Utils.flushBarErrorMessage("Error Logging out ... ", context,
          color: AppColors.redColor);
    }
  }
}
