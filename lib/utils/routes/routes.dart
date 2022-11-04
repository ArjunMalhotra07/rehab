import 'package:flutter/material.dart';
import 'package:rehab/pages/signup_screen.dart';
import 'package:rehab/utils/routes/routes_name.dart';

import '../../pages/login_screen.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(builder: ((context) => const LoginScreen()));

      case RoutesName.signup:
        return MaterialPageRoute(builder: ((context) => const SignupScreen()));
      default:
        return MaterialPageRoute(
            builder: ((context) => Scaffold(
                  appBar: AppBar(),
                  body: const Center(child: Text("No such route")),
                )));
    }
  }
}
