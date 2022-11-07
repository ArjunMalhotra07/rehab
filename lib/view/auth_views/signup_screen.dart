import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab/utils/components/round_buttons.dart';
import 'package:rehab/utils/routes/routes_name.dart';
import 'package:rehab/utils/utils.dart';
import 'package:rehab/view/auth_views/login_screen.dart';
import 'package:rehab/view_model/firebase_calls.dart';

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
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text("Sign Up"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBoxWidget.box(10.0),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                    hintText: 'Email', icon: Icon(Icons.mail)),
              ),
              SizedBoxWidget.box(10.0),
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
                    FirebaseCalls().signUp(
                      _email.text.toString(),
                      _pass.text.toString(),
                      context,
                    );
                  }
                },
              ),
              SizedBoxWidget.box(25.0),
              const Text("Already have an account?"),
              SizedBoxWidget.box(25.0),
              GestureDetector(
                onTap: () {
                  Get.offAll(const LoginScreen());
                },
                child: const Text(
                  "Log In",
                  style: TextStyle(color: Colors.green),
                ),
              )
            ],
          ),
        ));
  }
}
