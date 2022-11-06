import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/components/colors.dart';

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

  RxInt totalCounterVar = 0.obs;
  int get totalCounter => totalCounterVar.value;
  setTotalCounter(int value) {
    totalCounterVar.value = value;
    update();
  }

  funcGetAllEntries() async {
    int count = 0;
    final ref = FirebaseDatabase.instance.ref('uids/$userId/sessions');
    DatabaseEvent event = await ref.once();
    var object = event.snapshot;
    for (final json in object.children) {
      for (final _ in json.children) {
        count += 1;
        setTotalCounter(count);
      }
    }
  }

  RxString _name = ''.obs;
  String get nameVar => _name.value;
  setName(String value) {
    _name.value = value;
    update();
  }

  void getName(String uid) async {
    dynamic snapshot;
    var name;
    var dbRef = FirebaseDatabase.instance.ref('uids/$uid').child("name");
    snapshot = await dbRef.get();
    name = snapshot.value;
    setName(name);
  }
}
