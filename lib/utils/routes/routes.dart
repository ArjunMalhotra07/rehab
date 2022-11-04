import 'package:flutter/material.dart';
import 'package:rehab/pages/home_page.dart';
import 'package:rehab/pages/practice_page.dart';
import 'package:rehab/pages/profile_page.dart';
import 'package:rehab/pages/rehab_page.dart';
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

      case RoutesName.home:
        return MaterialPageRoute(builder: ((context) => const HomePage()));

      case RoutesName.rehab:
        return MaterialPageRoute(builder: ((context) => const RehabPage()));

      case RoutesName.practice:
        return MaterialPageRoute(builder: ((context) => const PracticePage()));

      case RoutesName.profile:
        return MaterialPageRoute(builder: ((context) => const ProfilePage()));
      default:
        return MaterialPageRoute(
            builder: ((context) => Scaffold(
                  appBar: AppBar(),
                  body: const Center(child: Text("No such route")),
                )));
    }
  }
}
