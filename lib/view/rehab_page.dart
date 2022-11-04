import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:rehab/utils/components/colors.dart';
import 'package:rehab/utils/components/round_buttons.dart';

class RehabPage extends StatefulWidget {
  const RehabPage({super.key});

  @override
  State<RehabPage> createState() => _RehabPageState();
}

class _RehabPageState extends State<RehabPage> {
  final user = FirebaseAuth.instance.currentUser;
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('');

  @override
  Widget build(BuildContext context) {
    var uid = user?.uid;
    final ref = FirebaseDatabase.instance.ref('uids/$uid/sessions');
    ref.onValue.listen((event) {
      for (final child in event.snapshot.children) {
        // Handle the post.
        var dataObject = child.value.toString();
        print(dataObject);
      }
    }, onError: (error) {});
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Text(
            "Rehab Programme",
            style: TextStyle(color: Constants.blackColor, fontSize: 30),
          ),
        ),
        SizedBoxWidget.box(10.0),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset('assets/doctor.png')),
        ),
        Expanded(
          child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: ((context, snapshot, animation, index) {
                // var object = (snapshot.children)[index];

                return const ListTile(
                    // title: Text(snapshot.children.toString()),
                    );
              })),
        )
      ],
    );
  }
}
