import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rehab/utils/components/card.dart';
import 'package:rehab/utils/components/colors.dart';
import 'package:rehab/utils/utils.dart';

import '../../utils/components/round_buttons.dart';
import '../../view_model/getter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int totalSessions = 10;
  final double multiplyingFactor = .1;
  final now = DateTime.now();
  late ListenFirebase1 controller = Get.put(ListenFirebase1(""));
  var uid = Constants().userId();
  @override
  void initState() {
    super.initState();

    controller = Get.put(ListenFirebase1(uid));
    controller.funcGetTodayEntries('${now.day}-${now.month}-${now.year}');
    controller.getName(uid);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    var day = now.day;
    var now2 = DateFormat('hh:mm a').format(DateTime.now());

    final databaseRef1 = FirebaseDatabase.instance.ref('uids/$uid/sessions');
    final ref = FirebaseDatabase.instance
        .ref('uids/$uid/sessions/${now.day}-${now.month}-${now.year}');

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
              child:
                  ListView(physics: const BouncingScrollPhysics(), children: [
                Obx(
                  () => TextStyleWidget.textStyle(
                      "Good Morning \n${controller.nameVar.toString()}", 35,
                      c: Constants.blackShade),
                ),
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
                                Obx(
                                  () => TextStyleWidget.textStyle(
                                      "${((controller.counter) / totalSessions) * 100}%",
                                      22,
                                      c: Constants.blueColor),
                                ),
                              ],
                            ),
                            SizedBoxWidget.box(20.0),
                            Obx(
                              () => LinearPercentIndicator(
                                lineHeight: 15,
                                progressColor: Constants.blueColor,
                                percent: controller.counter * multiplyingFactor,
                                animationDuration: 700,
                                animation: true,
                                barRadius: const Radius.circular(12),
                                backgroundColor: Constants.lightGreyColor,
                              ),
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
                                    " Pending \n${totalSessions - controller.counter} sessions",
                                    15,
                                    c: Constants.blackShade1)),
                              ],
                            ),
                          ],
                        ))),
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
                        var assetUrl = '';
                        if (((index + 1)) % 3 == 0) {
                          assetUrl = 'assets/woman1.jpg';
                        } else if (index % 3 == 1) {
                          assetUrl = 'assets/woman2.jpg';
                        } else {
                          assetUrl = 'assets/woman3.jpeg';
                        }
                        childrenWidget.add(CardWidget(
                          context: context,
                          status: "Complete",
                          title: snapshot.value.toString(),
                          height: 170.0,
                          width: 450.0,
                          time: "Performed at \n${snapshot.key.toString()}",
                          imageUrl: assetUrl,
                        ));
                        return Column(
                          children: childrenWidget,
                        );
                      })),
                ),
                // ListView.Builder
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: totalSessions - controller.counter,
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
                          title: "Session ${controller.counter + index + 1}",
                          height: 170.0,
                          width: 100.0,
                          imageUrl: assetUrl,
                          context: context,
                        );
                      }))),
                ),
                SizedBoxWidget.box(45.0)
              ]),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .68,
              child: Center(
                  child: Obx((() => RoundButton(
                        title: controller.counter == totalSessions
                            ? "Sessions Completed"
                            : "Start Session ${controller.counter + 1}",
                        width: 320,
                        onPress: () {
                          setState(() {
                            now2 = DateFormat('hh:mm a').format(DateTime.now());
                          });
                          if (controller.counter != totalSessions) {
                            var check = controller.keysList.any((element) =>
                                element.toLowerCase() == now2.toLowerCase());
                            if (check == false) {
                              databaseRef1
                                  .child("$day-${now.month}-${now.year}")
                                  .update({
                                now2: "Session ${controller.counter + 1}"
                              }).then((value) {
                                Utils.flushBarErrorMessage(
                                    "Added Session", context,
                                    color: Constants.blueColor);
                                controller.funcGetTodayEntries(
                                    '${now.day}-${now.month}-${now.year}');
                              }).catchError((error, stackTrace) {
                                if (kDebugMode) {
                                  print(error.toString());
                                }
                                Utils.flushBarErrorMessage(
                                    error.message.toString(), context);
                              });
                            } else {
                              Utils.flushBarErrorMessage(
                                  "You just finished the previous workout.",
                                  context);
                            }
                          } else {
                            Utils.flushBarErrorMessage(
                                "No sessions for today", context,
                                color: Constants.redColor);
                          }
                        },
                        buttonColor: Constants.blueColor,
                      )))),
            )
          ],
        ),
      ),
    );
  }
}
