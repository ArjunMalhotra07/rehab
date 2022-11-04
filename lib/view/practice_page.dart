import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rehab/utils/components/colors.dart';
import 'package:rehab/utils/utils.dart';
import 'package:rehab/view_model/firebase_calls.dart';

import '../utils/components/round_buttons.dart';

class PracticePage extends StatefulWidget {
  String? name;
  PracticePage({super.key, this.name});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var uid = user?.uid;

    final databaseRef = FirebaseDatabase.instance.ref('uids');
    print(uid);
    databaseRef.child("$uid").update({"name": "Arjun"}).then((value) {
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
    bool loading = false;
    var uid = user?.uid;
    final databaseRef1 = FirebaseDatabase.instance.ref('uids/$uid/sessions');
    final day = DateTime.now().day;
    final month = DateTime.now().month;
    final year = DateTime.now().year;
    final minute = DateTime.now().minute;
    final hour = DateTime.now().hour;
    // if (kDebugMode) {
    //   print(user?.email);
    //   print(user?.uid);
    //   print(day);
    //   print(month);
    //   print(year);
    //   print(minute);
    //   print(hour);
    // }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
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
                  databaseRef1
                      .child("$day-$month-$year")
                      .update({'$hour:$minute': "Example"}).then((value) {
                    Utils.flushBarErrorMessage("Added Session", context,
                        color: Constants.blueColor);
                  }).catchError((error, stackTrace) {
                    if (kDebugMode) {
                      print(error.toString());
                    }
                    Utils.flushBarErrorMessage(
                        error.message.toString(), context);
                  });
                }),
          ),
        ],
      ),
    );
  }
}
