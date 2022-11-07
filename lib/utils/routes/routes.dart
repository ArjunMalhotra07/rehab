import 'package:flutter/material.dart';
import 'package:rehab/view/check_login.dart';
import 'package:rehab/view/page_views/practice_screen.dart';
import 'package:rehab/view/main_view.dart';
import 'package:rehab/view/page_views/home_page.dart';
import 'package:rehab/view/page_views/profile_page.dart';
import 'package:rehab/view/page_views/rehab_page.dart';
import 'package:rehab/view/auth_views/signup_screen.dart';
import 'package:rehab/utils/routes/routes_name.dart';

import '../../view/auth_views/login_screen.dart';

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

      case RoutesName.check:
        return MaterialPageRoute(builder: ((context) => const CheckLogin()));

      case RoutesName.main:
        return MaterialPageRoute(builder: ((context) => const MainView()));

      default:
        return MaterialPageRoute(
            builder: ((context) => Scaffold(
                  appBar: AppBar(),
                  body: const Center(child: Text("No such route")),
                )));
    }
  }
}
