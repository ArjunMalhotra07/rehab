import 'package:flutter/material.dart';
import 'package:rehab/view/check_login.dart';
import 'package:rehab/view/practice_screen.dart';
import 'package:rehab/view/main_view.dart';
import 'package:rehab/view/home_page.dart';
import 'package:rehab/view/profile_page.dart';
import 'package:rehab/view/rehab_page.dart';
import 'package:rehab/view/signup_screen.dart';
import 'package:rehab/utils/routes/routes_name.dart';

import '../../view/login_screen.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(builder: ((context) => const LoginScreen()));

      case RoutesName.signup:
        return MaterialPageRoute(builder: ((context) => const SignupScreen()));

      case RoutesName.home:
        return MaterialPageRoute(builder: ((context) => HomePage()));

      case RoutesName.rehab:
        return MaterialPageRoute(builder: ((context) => const RehabPage()));

      case RoutesName.practice:
        return MaterialPageRoute(builder: ((context) => PracticePage()));

      case RoutesName.profile:
        return MaterialPageRoute(builder: ((context) => const ProfilePage()));

      case RoutesName.check:
        return MaterialPageRoute(builder: ((context) => const CheckLogin()));

      case RoutesName.main:
        return MaterialPageRoute(
            builder: ((context) => const MainView(
                  name: "",
                )));

      default:
        return MaterialPageRoute(
            builder: ((context) => Scaffold(
                  appBar: AppBar(),
                  body: const Center(child: Text("No such route")),
                )));
    }
  }
}
