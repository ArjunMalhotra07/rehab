import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab/utils/components/colors.dart';
import 'package:rehab/utils/components/round_buttons.dart';
import 'package:rehab/view_model/getter.dart';

class RehabPage extends StatefulWidget {
  const RehabPage({super.key});

  @override
  State<RehabPage> createState() => _RehabPageState();
}

class _RehabPageState extends State<RehabPage> {
  final ref = FirebaseDatabase.instance.ref('');

  final now = DateTime.now();
  late ListenFirebase1 controller = Get.put(ListenFirebase1(""));
  var uid = Constants().userId();
  @override
  void initState() {
    super.initState();
    controller = Get.put(ListenFirebase1(uid));
    controller.funcGetAllEntries();
  }

  @override
  Widget build(BuildContext context) {
    var uid = Constants().userId();
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
          physics: const BouncingScrollPhysics(),
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
                height: 90,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey.shade200,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 5),
                        Column(
                          children: [
                            TextStyleWidget.textStyle("Total sessions", 15),
                            Row(
                              children: [
                                Image.asset('assets/dumb.png'),
                                Obx((() => TextStyleWidget.textStyle(
                                    controller.totalCounterVar.value.toString(),
                                    30)))
                              ],
                            )
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
                          children: [
                            TextStyleWidget.textStyle("Total time", 15),
                            Row(
                              children: [
                                Image.asset('assets/hour.png'),
                                TextStyleWidget.textStyle("16", 30),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                )),
            SizedBoxWidget.box(20.0),
            FirebaseAnimatedList(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                query: ref,
                itemBuilder: ((context, snapshot, animation, index) {
                  var object = snapshot.children;
                  final childrenWidget = <Widget>[];
                  for (final timeStamp in object) {
                    counter += 1;
                    var assetUrl = '';
                    if (counter % 2 == 0) {
                      assetUrl = 'assets/pic1.png';
                    } else {
                      assetUrl = 'assets/pic2.png';
                    }
                    childrenWidget.add(list(timeStamp.key.toString(),
                        snapshot.key.toString(), assetUrl));
                  }
                  return Column(
                    children: childrenWidget,
                  );
                })),
          ],
        ),
      ),
    );
  }

  list(String title, subtitle, url) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SizedBox(
        child: Row(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                url,
                height: 70,
              )),
          const SizedBox(
            width: 30,
          ),
          Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.timer_sharp,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextStyleWidget.textStyle(title, 16, c: Constants.blackShade),
                ],
              ),
              SizedBoxWidget.box(5.0),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextStyleWidget.textStyle(subtitle, 14,
                      c: Constants.blackShade),
                ],
              ),
            ],
          ),
          const Spacer(),
          const Text("View Results")
        ]),
      ),
    );
  }
}
