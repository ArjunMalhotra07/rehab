import 'package:flutter/material.dart';

class PracticePage extends StatefulWidget {
  PracticePage({Key? key}) : super(key: key);

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Practice Page"));
  }
}
