import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class ListenFirebase extends ChangeNotifier {
  final user = FirebaseAuth.instance.currentUser;

  int _counter = 0;

  func() async {
    var count = 0;
    debugPrint("Inside Uid declaration");
    var uid = user?.uid;
    final ref = FirebaseDatabase.instance.ref('uids/$uid/sessions');
    DatabaseEvent event = await ref.once();

    var children = event.snapshot.children;
    var childrenLength = event.snapshot.children.length;
    debugPrint("Length -- > ");
    debugPrint(childrenLength.toString());
    debugPrint(event.snapshot.value.toString());
    for (final object in children) {
      var json = object;
      debugPrint(object.key);

      setCounter(count);
      for (final timeStampe in json.children) {
        debugPrint(timeStampe.key);
        count++;
        setCounter(count);
      }
    }

    debugPrint(count.toString());

    debugPrint("");
  }

  void uidDeclaration() async {
    var uid = user?.uid;
    final ref = FirebaseDatabase.instance.ref('uids/$uid/sessions');
    DatabaseEvent event = await ref.once();
    print(event.snapshot.value);
  }

  int get counter => _counter;
  setCounter(int value) {
    _counter = value;
    print(_counter);
    notifyListeners();
  }
}
