import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListenFirebase1 extends GetxController {
  final user = FirebaseAuth.instance.currentUser;
  final String? userId;
  ListenFirebase1(this.userId);
  final now = DateTime.now();
  final now2 = DateFormat('hh:mm a').format(DateTime.now());

  RxInt counterVar = 0.obs;
  int get counter => counterVar.value;
  setCounter(int value) {
    counterVar.value = value;
    update();
  }

  funcGetTodayEntries(String s) async {
    int count = 0;
    final ref = FirebaseDatabase.instance.ref('uids/$userId/sessions/$s');
    DatabaseEvent event = await ref.once();
    var object = event.snapshot;
    for (final _ in object.children) {
      count += 1;
      setCounter(count);
    }
  }

  int counterTest = 16;
}
