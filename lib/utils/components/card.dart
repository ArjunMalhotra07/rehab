import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rehab/utils/components/colors.dart';
import 'package:rehab/utils/components/round_buttons.dart';
import 'package:rehab/utils/utils.dart';

class CardWidget extends StatefulWidget {
  final String? title;
  final String? imageUrl;
  final String? time;
  final double height, width;
  final String? status;
  final int? counterVar;
  const CardWidget(
      {super.key,
      this.time,
      this.imageUrl,
      this.title,
      required this.height,
      required this.width,
      this.counterVar,
      this.status});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final now = DateTime.now();
  final now2 = DateFormat('hh:mm a').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    var uid = user?.uid;
    final databaseRef1 = FirebaseDatabase.instance.ref('uids/$uid/sessions');
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: Constants.whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Constants.lightGreyColor, width: 3)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 11.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBoxWidget.box(10.0),
                  TextStyleWidget.textStyle(widget.title.toString(), 21,
                      c: Constants.blackShade),
                  RoundButton(
                    title: widget.status ?? "Start",
                    onPress: () {
                      if (widget.counterVar != 10) {
                        widget.status == null
                            ? () {
                                databaseRef1
                                    .child(
                                        "${now.day}-${now.month}-${now.year}")
                                    .update({now2: "${widget.title}"}).then(
                                        (value) {
                                  Utils.flushBarErrorMessage(
                                      "Added Session", context,
                                      color: Constants.blueColor);
                                }).catchError((error, stackTrace) {
                                  if (kDebugMode) {
                                    print(error.toString());
                                  }
                                  Utils.flushBarErrorMessage(
                                      error.message.toString(), context);
                                });
                              }
                            : () {
                                Utils.flushBarErrorMessage(
                                    "This session is completed", context);
                              };
                      } else {
                        Utils.flushBarErrorMessage(
                            "No sessions for today", context,
                            color: Constants.redColor);
                      }
                    },
                    height: 30,
                    buttonColor: widget.status == null
                        ? Colors.grey.shade300
                        : Constants.blueColor,
                    width: 100,
                    titleSize: 15,
                  ),
                  TextStyleWidget.textStyle(widget.time.toString(), 15,
                      c: Constants.greyColor),
                  SizedBoxWidget.box(10.0),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  widget.imageUrl ?? 'assets/woman.png',
                  height: 200,
                  width: 150,
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
