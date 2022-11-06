import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab/utils/components/round_buttons.dart';
import 'package:rehab/view/test.dart';
import 'package:rehab/view_model/getter.dart';

import '../utils/components/colors.dart';

class PracticePage extends StatefulWidget {
  PracticePage({Key? key}) : super(key: key);

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    var uid = user?.uid;
    final controller = Get.put(ListenFirebase1(uid));
    return Center(
        child: RoundButton(
      title: "Dummy Page",
      width: 320,
      onPress: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DummyHomePage()),
        );
      },
      buttonColor: Constants.blueColor,
    ));
  }
}
