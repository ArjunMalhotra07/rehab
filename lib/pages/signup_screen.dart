import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rehab/utils/colors.dart';
import 'package:rehab/utils/components/round_buttons.dart';
import 'package:rehab/utils/routes/routes_name.dart';
import 'package:rehab/utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
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
    // final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
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
                title: 'Sign up',
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
                      print("Sign Up");
                    }
                    signUp();
                  }
                },
              ),
            ],
          ),
        ));
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.text, password: _pass.text)
          .then((value) {
        if (kDebugMode) {
          print("Id ${value.user?.email}");
        }

        Utils.flushBarErrorMessage("Sign Up Successful", context,
            color: AppColors.greenColor);
        Timer(const Duration(seconds: 3), () {
          Navigator.pushNamed(context, RoutesName.practice);
        });
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
    }
  }
}
