import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rehab/utils/components/colors.dart';
import 'package:rehab/utils/components/round_buttons.dart';

import '../../utils/utils.dart';
import '../../view_model/firebase_calls.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _name = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _name,
            decoration: const InputDecoration(
                hintText: 'Name', icon: Icon(Icons.person)),
          ),
          SizedBoxWidget.box(50.0),
          Center(
            child: RoundButton(
                width: 300,
                buttonColor: Constants.blueColor,
                title: "Add Name",
                onPress: () {
                  final user = FirebaseAuth.instance.currentUser;
                  var uid = user?.uid;
                  final databaseRef = FirebaseDatabase.instance.ref('uids');
                  databaseRef
                      .child("$uid")
                      .update({"name": _name.text}).then((value) {
                    Utils.flushBarErrorMessage("Name Added", context,
                        color: Constants.greenColor);
                    _name.clear();
                  }).catchError((error, stackTrace) {
                    if (kDebugMode) {
                      print(error.toString());
                    }
                    Utils.flushBarErrorMessage(
                        error.message.toString(), context);
                  });
                }),
          ),
          SizedBoxWidget.box(50.0),
          // Center(
          //   child: RoundButton(
          //       width: 300,
          //       buttonColor: Constants.blueColor,
          //       title: "Sign Out",
          //       onPress: () {
          //         FirebaseCalls().signOut(context);
          //       }),
          // ),
        ],
      ),
    );
  }
}
