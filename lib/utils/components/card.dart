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
  final BuildContext context;
  const CardWidget(
      {super.key,
      this.time,
      this.imageUrl,
      this.title,
      required this.height,
      required this.width,
      this.counterVar,
      required this.context,
      this.status});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final now = DateTime.now();
  final now2 = DateFormat('hh:mm a').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
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
                  widget.status != "Incomplete"
                      ? RoundButton(
                          title: widget.status == "Complete"
                              ? "Completed"
                              : "Start",
                          onPress: widget.status == "Incomplete"
                              ? () {}
                              : () {
                                  Utils.flushBarErrorMessage(
                                      "This session is already completed",
                                      context);
                                },
                          height: 30,
                          buttonColor: widget.status == "Incomplete"
                              ? Colors.grey.shade300
                              : Constants.blueColor,
                          width: 100,
                          titleSize: 15,
                        )
                      : Container(),
                  TextStyleWidget.textStyle(
                      widget.time != null ? widget.time.toString() : "", 15,
                      c: Constants.greyColor),
                  SizedBoxWidget.box(10.0),
                ],
              ),
            ),
            const Spacer(),
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
