import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:rehab/utils/components/colors.dart';
import 'package:rehab/utils/components/round_buttons.dart';

class RehabPage extends StatefulWidget {
  const RehabPage({super.key});

  @override
  State<RehabPage> createState() => _RehabPageState();
}

class _RehabPageState extends State<RehabPage> {
  final user = FirebaseAuth.instance.currentUser;
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final childrenWidgetList = <Widget>[];

    // final childrenWidget = <Widget>[];
    var uid = user?.uid;
    final testList = <String>[];
    int counter = 0;
    final ref = FirebaseDatabase.instance.ref('uids/$uid/sessions');
    return Scaffold(
      backgroundColor: Constants.whiteColor,
      appBar: AppBar(
        backgroundColor: Constants.whiteColor,
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30),
        child: ListView(
          children: [
            const Text(
              "Rehab Programme",
              style: TextStyle(color: Constants.blackColor, fontSize: 30),
            ),
            SizedBoxWidget.box(10.0),
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset('assets/doctor.png')),
            SizedBoxWidget.box(10.0),
            Row(
              children: [
                const Text(
                  "History",
                  style: TextStyle(color: Constants.blackColor, fontSize: 22),
                ),
                const Spacer(),
                Image.asset('assets/funnel.png', height: 30, fit: BoxFit.fill),
              ],
            ),
            SizedBoxWidget.box(5.0),
            Container(
                height: 85,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey.shade400,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 5),
                        Column(
                          children: const [
                            Text(
                              "Total Sessions",
                              style: TextStyle(
                                  color: Constants.blackColor, fontSize: 15),
                            ),
                            Text("16")
                          ],
                        ),
                        const SizedBox(width: 5),
                        Container(
                          width: 1,
                          height: 25,
                          color: Constants.blackColor,
                        ),
                        const SizedBox(width: 5),
                        Column(
                          children: const [
                            Text(
                              "Total time",
                              style: TextStyle(
                                  color: Constants.blackColor, fontSize: 15),
                            ),
                            Text("16")
                          ],
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                )),
            FirebaseAnimatedList(
                shrinkWrap: true,
                query: ref,
                itemBuilder: ((context, snapshot, animation, index) {
                  var object = snapshot.children; //Every time stamp
                  int length = object.length;
                  debugPrint("Key --> ${snapshot.key}");
                  debugPrint("length of Object --> ${length.toString()}");
                  final childrenWidget = <Widget>[];
                  for (final timeStamp in object) {
                    counter += 1;
                    debugPrint(timeStamp.key);
                    childrenWidget.add(list(
                        timeStamp.key.toString(), snapshot.key.toString()));
                  }
                  debugPrint("Terminate");
                  debugPrint("");
                  return Column(
                    children: childrenWidget,
                  );
                })),
          ],
        ),
      ),
    );
  }

  list(String title, subtitle) {
    return ListTile(
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'assets/pic1.png',
          )),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Text("View Results"),
    );
  }
}
