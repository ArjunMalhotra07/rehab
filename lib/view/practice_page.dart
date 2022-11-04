import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rehab/utils/components/round_buttons.dart';
import 'package:rehab/view_model/firebase_calls.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    print(user?.email);
    print(user?.uid);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body:
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Center(child: Text("Practice Page")),
            //     RoundButton(
            //         title: "Sign Out",
            //         onPress: () {
            //           FirebaseCalls().signOut(context);
            //         })
            //   ],
            // ),
            Container());
  }
}
