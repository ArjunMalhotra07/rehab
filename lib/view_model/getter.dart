import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ListenFirebase extends ChangeNotifier {
  final user = FirebaseAuth.instance.currentUser;

  int _counter = 0;
  int get counter => _counter;
  setCounter(int value) {
    _counter = value;
    notifyListeners();
  }

  final now = DateTime.now();
  final now2 = DateFormat('hh:mm a').format(DateTime.now());

  funcGetTodayEntries(String s) async {
    var count = 0;
    debugPrint("***************");
    var uid = user?.uid;
    final ref = FirebaseDatabase.instance.ref('uids/$uid/sessions/$s');
    DatabaseEvent event = await ref.once();
    var object = event.snapshot;
    debugPrint(object.key);
    for (final children in object.children) {
      debugPrint(children.key);
      count += 1;
      setCounter(count);
    }
    print(count);
  }
}
