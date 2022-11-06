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
    print(_counter);
    notifyListeners();
  }

  final now = DateTime.now();
  final now2 = DateFormat('hh:mm a').format(DateTime.now());
  func() async {
    var count = 0;
    debugPrint("Inside func method ");
    var uid = user?.uid;
    final ref = FirebaseDatabase.instance.ref('uids/$uid/sessions');
    DatabaseEvent event = await ref.once();
    var children = event.snapshot.children;
    for (final object in children) {
      var json = object;
      setCounter(count);
      for (final timeStampe in json.children) {
        if (object.key == "${now.day}-${now.month}-${now.year}") {
          debugPrint(timeStampe.key);
          count += 1;
          setCounter(count);
        }
      }
    }
  }
}
