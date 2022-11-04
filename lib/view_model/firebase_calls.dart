import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rehab/utils/components/colors.dart';
import 'package:rehab/utils/utils.dart';
import 'package:rehab/view/home_page.dart';

import '../utils/routes/routes_name.dart';

class FirebaseCalls {
  var firebaseObject = FirebaseAuth.instance;
  final day = DateTime.now().day;
  final month = DateTime.now().month;
  final year = DateTime.now().year;
  final minute = DateTime.now().minute;
  final hour = DateTime.now().hour;

  Future signUp(String email, pass, BuildContext context, String name) async {
    try {
      await firebaseObject
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((value) {
        if (kDebugMode) {
          print("Id ${value.user?.email}");
        }

        Timer(const Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      name: name,
                    )),
          );
        });
        Utils.flushBarErrorMessage("Sign Up Successful", context,
            color: Constants.greenColor);
      }).catchError((error, stackTrace) {
        if (kDebugMode) {
          print("error");
          print(error.message);
        }
        Utils.flushBarErrorMessage(error.message.toString(), context,
            color: Constants.redColor);
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }

      Utils.flushBarErrorMessage("Error Signing in ... ", context,
          color: Constants.redColor);
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
          Navigator.popAndPushNamed(context, RoutesName.main);
        });
        Utils.flushBarErrorMessage("Login Successful", context,
            color: Constants.blueColor);
      }).catchError((error, stackTrace) {
        if (kDebugMode) {
          print("Error");
          print(error.message);
        }
        Utils.flushBarErrorMessage(error.message.toString(), context,
            color: Constants.redColor);
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Firebase Auth Exception Login");
        print(e.message);
      }

      Utils.flushBarErrorMessage("Error Logging In ... ", context,
          color: Constants.redColor);
    }
  }

  Future signOut(BuildContext context) async {
    try {
      firebaseObject.signOut().then((value) {
        Timer(const Duration(seconds: 1), () {
          Navigator.popAndPushNamed(context, RoutesName.login);
        });
        Utils.flushBarErrorMessage("Logged out successfully ", context,
            color: Constants.blueColor);
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Firebase Auth Exception Logout");
        print(e.message);
      }
      Utils.flushBarErrorMessage("Error Logging out ... ", context,
          color: Constants.redColor);
    }
  }

  void postDataToFirebase(String uid) {
    final databaseRef = FirebaseDatabase.instance.ref('id/$uid/sessions');
    return postDataToFirebase(uid);
  }
}
