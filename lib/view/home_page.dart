import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rehab/utils/components/colors.dart';
import 'package:rehab/utils/utils.dart';
import 'package:rehab/view_model/firebase_calls.dart';

import '../utils/components/round_buttons.dart';

class HomePage extends StatefulWidget {
  String? name;
  HomePage({super.key, this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("name --- ");
      print(widget.name);
    }
    if (widget.name != null) {
      addData();
    }
  }

  addData() {
    var uid = user?.uid;
    final databaseRef = FirebaseDatabase.instance.ref('uids');
    print(uid);
    databaseRef.child("$uid").update({"name": widget.name}).then((value) {
      print("Added name");
      // Utils.flushBarErrorMessage("Added Session", context,
      //     color: Constants.blueColor);
    }).catchError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      Utils.flushBarErrorMessage(error.message.toString(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var uid = user?.uid;
    final now = DateTime.now();
    var day = now.day;
    print(now.toLocal());
    final databaseRef1 = FirebaseDatabase.instance.ref('uids/$uid/sessions');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundButton(
            title: "Sign Out",
            onPress: () {
              FirebaseCalls().signOut(context);
            }),
        SizedBoxWidget.box(50.0),
        Center(
          child: RoundButton(
              title: "Add data",
              onPress: () {
                if (kDebugMode) {
                  print("Clicked");
                }
                databaseRef1.child("${day}-${now.month}-${now.year}").update({
                  '${now.hour}:${now.minute}': "Example${now.microsecond}"
                }).then((value) {
                  Utils.flushBarErrorMessage("Added Session", context,
                      color: Constants.blueColor);
                }).catchError((error, stackTrace) {
                  if (kDebugMode) {
                    print(error.toString());
                  }
                  Utils.flushBarErrorMessage(error.message.toString(), context);
                });
              }),
        ),
      ],
    );
  }
}
