import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehab/utils/components/round_buttons.dart';
import 'package:rehab/view_model/getter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int? count = 1;
  @override
  void initState() {
    super.initState();
    ListenFirebase().func();

    count = ListenFirebase().counter;
  }

  @override
  Widget build(BuildContext context) {
    final myCounter = context.watch<ListenFirebase>();
    return ChangeNotifierProvider(
      create: (_) => ListenFirebase(),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${myCounter.counter}"),
          RoundButton(
              title: "Call Func",
              onPress: () {
                ListenFirebase().func();
              })
        ],
      )),
    );
  }
}
