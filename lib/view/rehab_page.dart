import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

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
        print("inside");
        print(dataObject);
        print("");
      }
    }, onError: (error) {});
    return Column(
      children: [
        Expanded(
          child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: ((context, snapshot, animation, index) {
                // var object = (snapshot.children)[index];

                return ListTile(
                  title: Text(snapshot.children.toString()),
                );
              })),
        )
      ],
    );
  }
}
