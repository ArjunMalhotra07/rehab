import 'package:flutter/material.dart';
import 'package:rehab/utils/components/colors.dart';
import 'package:rehab/utils/components/round_buttons.dart';
import 'package:rehab/view_model/firebase_calls.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: TextStyleWidget.textStyle("Profile Page", 15,
              c: Constants.blackShade1),
        ),
        SizedBoxWidget.box(50.0),
        RoundButton(
            buttonColor: Constants.blueColor,
            title: "Sign Out",
            onPress: () {
              FirebaseCalls().signOut(context);
            }),
      ],
    );
  }
}
