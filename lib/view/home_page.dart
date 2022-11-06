import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:rehab/utils/components/card.dart';
import 'package:rehab/utils/components/colors.dart';
import 'package:rehab/utils/utils.dart';

import '../utils/components/round_buttons.dart';
import '../view_model/getter.dart';

class HomePage extends StatefulWidget {
  String? name;
  HomePage({super.key, this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final now = DateTime.now();
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    context
        .read<ListenFirebase>()
        .funcGetTodayEntries("${now.day}-${now.month}-${now.year}");
  }

  @override
  Widget build(BuildContext context) {
    var uid = user?.uid;
    final now = DateTime.now();
    var day = now.day;
    final now2 = DateFormat('hh:mm a').format(DateTime.now());

    final databaseRef1 = FirebaseDatabase.instance.ref('uids/$uid/sessions');
    final ref = FirebaseDatabase.instance
        .ref('uids/$uid/sessions/${now.day}-${now.month}-${now.year}');

    final myCounter = context.watch<ListenFirebase>();
    final myFlag = context.watch<ListenFirebase>();
    return ChangeNotifierProvider(
      create: (_) => ListenFirebase(),
      child: Scaffold(
        backgroundColor: Constants.whiteColor,
        appBar: AppBar(
          backgroundColor: Constants.whiteColor,
          toolbarHeight: 0,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 25.0, left: 35, right: 35, bottom: 10),
          child: Stack(
            children: [
              Container(
                child: ListView(children: [
                  TextStyleWidget.textStyle("Good Morning \nJane", 35,
                      c: Constants.blackShade),
                  SizedBoxWidget.box(15.0),
                  Container(
                      decoration: BoxDecoration(
                          color: Constants.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Constants.greyColor, width: 3)),
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                TextStyleWidget.textStyle(
                                    "Today's Progress", 23,
                                    c: Constants.blackShade1),
                                const Spacer(),
                                TextStyleWidget.textStyle(
                                    "${myCounter.counter * 10}%", 22,
                                    c: Constants.blueColor),
                              ],
                            ),
                            SizedBoxWidget.box(20.0),
                            LinearPercentIndicator(
                              lineHeight: 15,
                              progressColor: Constants.blueColor,
                              percent: myCounter.counter * .1,
                              animationDuration: 700,
                              animation: true,
                              barRadius: const Radius.circular(12),
                              backgroundColor: Constants.lightGreyColor,
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Image.asset('assets/tick.png',
                                    height: 50, fit: BoxFit.fill),
                                TextStyleWidget.textStyle(
                                    "Completed \n${myCounter.counter} sessions",
                                    15,
                                    c: Constants.blackShade1),
                                const Spacer(),
                                Image.asset('assets/arrow.png',
                                    height: 50, fit: BoxFit.fill),
                                TextStyleWidget.textStyle(
                                    " Pending \n${10 - myCounter.counter} sessions",
                                    15,
                                    c: Constants.blackShade1),
                              ],
                            ),
                          ],
                        ),
                      )),
                  SizedBoxWidget.box(35.0),
                  // FirebaseAnimatedList
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: FirebaseAnimatedList(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        query: ref,
                        itemBuilder: ((context, snapshot, animation, index) {
                          final childrenWidget = <Widget>[];
                          childrenWidget.add(CardWidget(
                            context: context,
                            status: "Complete",
                            title: snapshot.value.toString(),
                            height: 170.0,
                            width: 450.0,
                            time: "Performed at \n${snapshot.key.toString()}",
                            counterVar: myCounter.counter,
                          ));
                          return Column(
                            children: childrenWidget,
                          );
                        })),
                  ),
                  // ListView.Builder
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: 10 - myCounter.counter,
                        itemBuilder: ((context, index) {
                          var assetUrl = '';
                          if (index % 3 == 0) {
                            assetUrl = 'assets/woman1.jpg';
                          } else if (index % 3 == 1) {
                            assetUrl = 'assets/woman2.jpg';
                          } else {
                            assetUrl = 'assets/woman3.jpeg';
                          }
                          return CardWidget(
                            status: "Incomplete",
                            title: "Session ${myCounter.counter + index + 1}",
                            height: 170.0,
                            width: 100.0,
                            imageUrl: assetUrl,
                            context: context,
                          );
                        })),
                  ),
                  SizedBoxWidget.box(45.0)
                ]),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .68,
                child: Center(
                    child: RoundButton(
                  title: "Start Session ${myCounter.counter + 1}",
                  width: 320,
                  onPress: () {
                    if (myCounter.counter != 10) {
                      if (kDebugMode) {
                        print("Clicked");
                      }
                      databaseRef1
                          .child("$day-${now.month}-${now.year}")
                          .update({
                        now2: "Session ${myCounter.counter + 1}"
                      }).then((value) {
                        Utils.flushBarErrorMessage("Added Session", context,
                            color: Constants.blueColor);
                        context.read<ListenFirebase>().funcGetTodayEntries(
                            "${now.day}-${now.month}-${now.year}");
                      }).catchError((error, stackTrace) {
                        if (kDebugMode) {
                          print(error.toString());
                        }
                        Utils.flushBarErrorMessage(
                            error.message.toString(), context);
                      });
                    } else {
                      Utils.flushBarErrorMessage(
                          "No sessions for today", context,
                          color: Constants.redColor);
                    }
                  },
                  buttonColor: Constants.blueColor,
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
