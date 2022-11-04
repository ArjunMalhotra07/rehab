import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rehab/utils/colors.dart';
import 'package:rehab/utils/routes/routes_name.dart';

import '../utils/components/round_buttons.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);
  final TextEditingController _email = TextEditingController();

  final TextEditingController _pass = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _pass.dispose();
    _obscureText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Log In"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                    hintText: 'Email', icon: Icon(Icons.mail)),
              ),
              ValueListenableBuilder(
                  valueListenable: _obscureText,
                  builder: ((context, value, child) => TextFormField(
                        obscureText: _obscureText.value,
                        obscuringCharacter: '*',
                        controller: _pass,
                        decoration: InputDecoration(
                            suffixIcon: _obscureText.value
                                ? GestureDetector(
                                    onTap: () {
                                      _obscureText.value = !_obscureText.value;
                                    },
                                    child: const Icon(Icons.visibility_off))
                                : GestureDetector(
                                    onTap: () {
                                      _obscureText.value = !_obscureText.value;
                                    },
                                    child: const Icon(Icons.visibility)),
                            hintText: 'Password',
                            icon: const Icon(Icons.key)),
                      ))),
              SizedBoxWidget.box(50.0),
              RoundButton(
                title: 'Login',
                onPress: () {
                  if (_email.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Email cannot be empty", context);
                  } else if (_pass.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Password cannot be empty", context);
                  } else if (_pass.text.length < 6) {
                    Utils.flushBarErrorMessage(
                        "Password cannot be less than 6", context);
                  } else {
                    if (kDebugMode) {
                      print("Log in");
                    }
                    signIn();
                  }
                },
              ),
              SizedBoxWidget.box(25.0),
              const Text("Don't have an account?"),
              SizedBoxWidget.box(25.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.signup);
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.green),
                ),
              )
            ],
          ),
        ));
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email.text, password: _pass.text)
          .then((value) {
        if (kDebugMode) {
          print("Id $value");
        }
        Utils.flushBarErrorMessage("Login Successful", context,
            color: AppColors.greenColor);
        Timer(const Duration(seconds: 3), () {
          Navigator.pushNamed(context, RoutesName.practice);
        });
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
    }
  }
}
