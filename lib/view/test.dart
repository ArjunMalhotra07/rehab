import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:rehab/utils/components/colors.dart';

import '../utils/components/round_buttons.dart';
import '../view_model/getter.dart';

class DummyHomePage extends StatefulWidget {
  DummyHomePage({super.key});

  @override
  State<DummyHomePage> createState() => _DummyHomePageState();
}

class _DummyHomePageState extends State<DummyHomePage> {
  final now = DateTime.now();
  final user = FirebaseAuth.instance.currentUser;
  late ListenFirebase1 controller = Get.put(ListenFirebase1(""));
  @override
  void initState() {
    super.initState();
    var uid = user?.uid;
    controller = Get.put(ListenFirebase1(uid));
    Get.find<ListenFirebase1>()
        .funcGetTodayEntries('${now.day}-${now.month}-${now.year}');
    getName();
  }

  dynamic snapshot;
  var name;
  void getName() async {
    var uid = user?.uid;
    var dbRef = FirebaseDatabase.instance.ref('uids/$uid').child("name");
    snapshot = await dbRef.get(); // 👈 Use await here
    name = snapshot.value;
  }

  @override
  void dispose() {
    super.dispose();

    // controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(
              child: ListView(children: [
                SizedBoxWidget.box(100.0),
                name == null
                    ? TextStyleWidget.textStyle("Good Morning \n", 35,
                        c: Constants.blackShade)
                    : TextStyleWidget.textStyle(
                        "Good Morning \n${snapshot.value}", 35,
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
                              TextStyleWidget.textStyle("Today's Progress", 23,
                                  c: Constants.blackShade1),
                              const Spacer(),
                              Obx(
                                () => TextStyleWidget.textStyle(
                                    "${controller.counter * 10}%", 22,
                                    c: Constants.blueColor),
                              ),
                            ],
                          ),
                          SizedBoxWidget.box(20.0),
                          LinearPercentIndicator(
                            lineHeight: 15,
                            progressColor: Constants.blueColor,
                            percent: controller.counter * .1,
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
                              Obx(() => TextStyleWidget.textStyle(
                                  "Completed \n${controller.counter} sessions",
                                  15,
                                  c: Constants.blackShade1)),
                              const Spacer(),
                              Image.asset('assets/arrow.png',
                                  height: 50, fit: BoxFit.fill),
                              Obx(() => TextStyleWidget.textStyle(
                                  " Pending \n${10 - controller.counter} sessions",
                                  15,
                                  c: Constants.blackShade1)),
                            ],
                          ),
                        ],
                      ),
                    )),
              ]),
            ),
            /*
            Positioned(
              top: MediaQuery.of(context).size.height * .5,
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
            )*/
          ],
        ),
      ),
    );
  }
}
