import 'package:flutter/material.dart';
import 'package:rehab/utils/components/colors.dart';
import 'package:rehab/utils/components/round_buttons.dart';

class CardWidget extends StatefulWidget {
  final String? title;
  final String? imageUrl;
  final String? time;
  final double height, width;
  final String? status;
  const CardWidget(
      {super.key,
      this.time,
      this.imageUrl,
      this.title,
      required this.height,
      required this.width,
      this.status});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
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
                  RoundButton(
                    title: widget.status ?? "Start",
                    onPress: () {},
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
