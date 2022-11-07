import 'package:flutter/material.dart';
import 'package:rehab/utils/components/round_buttons.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({Key? key}) : super(key: key);

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextStyleWidget.textStyle("Practice Page", 22),
    );
  }
}
