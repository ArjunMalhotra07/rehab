// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:rehab/utils/components/colors.dart';
// import 'package:rehab/utils/utils.dart';
// import 'package:rehab/view_model/firebase_calls.dart';

// import '../utils/components/round_buttons.dart';

// class HomePage extends StatefulWidget {
//   String? name;
//   HomePage({super.key, this.name});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final user = FirebaseAuth.instance.currentUser;
//   @override
//   void initState() {
//     super.initState();
//     if (kDebugMode) {
//       print("name --- ");
//       print(widget.name);
//     }
//     if (widget.name != null || widget.name != "") {
//       addData();
//     }
//   }

//   addData() {
//     var uid = user?.uid;
//     final databaseRef = FirebaseDatabase.instance.ref('uids');
//     print(uid);
//     databaseRef.child("$uid").update({"name": widget.name}).then((value) {
//       print("Added name");
//       // Utils.flushBarErrorMessage("Added Session", context,
//       //     color: Constants.blueColor);
//     }).catchError((error, stackTrace) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//       Utils.flushBarErrorMessage(error.message.toString(), context);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var uid = user?.uid;
//     final now = DateTime.now();
//     var day = now.day;
//     print(now.toLocal());
//     final databaseRef1 = FirebaseDatabase.instance.ref('uids/$uid/sessions');

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         RoundButton(
//             title: "Sign Out",
//             onPress: () {
//               FirebaseCalls().signOut(context);
//             }),
//         SizedBoxWidget.box(50.0),
//         Center(
//           child: RoundButton(
//               title: "Add data",
// onPress: () {
// if (kDebugMode) {
//   print("Clicked");
// }
// databaseRef1.child("${day}-${now.month}-${now.year}").update({
//   '${now.hour}:${now.minute}': "Example${now.microsecond}"
// }).then((value) {
//   Utils.flushBarErrorMessage("Added Session", context,
//       color: Constants.blueColor);
// }).catchError((error, stackTrace) {
//   if (kDebugMode) {
//     print(error.toString());
//   }
//   Utils.flushBarErrorMessage(error.message.toString(), context);
// });
// }),
//         ),
//       ],
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rehab/utils/components/card.dart';
import 'package:rehab/utils/components/colors.dart';
import 'package:rehab/utils/utils.dart';

import '../utils/components/round_buttons.dart';
import '../view_model/getter.dart';

class HomePage extends StatefulWidget {
  String? name;
  HomePage({super.key, this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("name --- ");
      print(widget.name);
    }
    if (widget.name != null || widget.name != "") {
      addData();
    }
    ListenFirebase().func();
  }

  addData() {
    var uid = user?.uid;
    final databaseRef = FirebaseDatabase.instance.ref('uids');
    final ref = FirebaseDatabase.instance.ref('uids/$uid/sessions');
    print(uid);
    databaseRef.child("$uid").update({"name": widget.name}).then((value) {
      print("Added name");
      // Utils.flushBarErrorMessage("Added Session", context,
      //     color: Constants.blueColor);
    }).catchError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      Utils.flushBarErrorMessage(error.message.toString(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<ListenFirebase>(context);

    ValueNotifier<int?> data = ValueNotifier(ListenFirebase().counter);
    var uid = user?.uid;
    final now = DateTime.now();
    var day = now.day;
    final now2 = DateFormat('hh:mm a').format(DateTime.now());

    if (kDebugMode) {
      print(now.toLocal());
      print(now2);
    }
    int _counter = 0;
    final databaseRef1 = FirebaseDatabase.instance.ref('uids/$uid/sessions');
    final ref = FirebaseDatabase.instance.ref('uids/$uid/sessions');
    return Scaffold(
      backgroundColor: Constants.whiteColor,
      appBar: AppBar(
        backgroundColor: Constants.whiteColor,
        toolbarHeight: 0,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 25.0, left: 35, right: 35, bottom: 10),
        child: Stack(
          children: [
            Container(
              child: ListView(children: [
                TextStyleWidget.textStyle("Good Morning \nJane", 35,
                    c: Constants.blackShade),
                SizedBoxWidget.box(15.0),
                Container(
                    decoration: BoxDecoration(
                        color: Constants.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Constants.greyColor, width: 3)),
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              TextStyleWidget.textStyle("Today's Progress", 23,
                                  c: Constants.blackShade1),
                              const Spacer(),
                              TextStyleWidget.textStyle("50%", 22,
                                  c: Constants.blueColor),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Image.asset('assets/tick.png',
                                  height: 50, fit: BoxFit.fill),
                              // ValueListenableBuilder(
                              //   valueListenable: data,
                              //   builder: (BuildContext context, int value,
                              //       Widget? child) {
                              //     // This builder will only get called when the _counter
                              //     // is updated.
                              //     return TextStyleWidget.textStyle(
                              //         "Completed \n$_counter sessions", 15,
                              //         c: Constants.blackShade1);
                              //   },
                              // ),
                              const Spacer(),
                              Image.asset('assets/arrow.png',
                                  height: 50, fit: BoxFit.fill),
                              TextStyleWidget.textStyle(
                                  " Pending \n2 sessions", 15,
                                  c: Constants.blackShade1),
                            ],
                          ),
                        ],
                      ),
                    )),
                SizedBoxWidget.box(35.0),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: FirebaseAnimatedList(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      query: ref,
                      itemBuilder: ((context, snapshot, animation, index) {
                        var object = snapshot.children; //Every time stamp
                        final childrenWidget = <Widget>[];
                        for (final timeStamp in object) {
                          if (snapshot.key ==
                              "${now.day}-${now.month}-${now.year}") {
                            debugPrint(timeStamp.key);
                            _counter += 1;
                            var assetUrl = '';
                            if (_counter % 3 == 0) {
                              assetUrl = 'assets/woman1.jpg';
                            } else if (_counter % 3 == 1) {
                              assetUrl = 'assets/woman2.jpg';
                            } else {
                              assetUrl = 'assets/woman3.jpeg';
                            }
                            childrenWidget.add(CardWidget(
                              status: "Complete",
                              title: "Session",
                              height: 170.0,
                              width: 450.0,
                              time:
                                  "Performed at \n${timeStamp.key.toString()}",
                              imageUrl: assetUrl,
                            ));
                          }
                        }
                        return Column(
                          children: childrenWidget,
                        );
                      })),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: ((context, index) {
                        var assetUrl = '';
                        if (index % 3 == 0) {
                          assetUrl = 'assets/woman1.jpg';
                        } else if (index % 3 == 1) {
                          assetUrl = 'assets/woman2.jpg';
                        } else {
                          assetUrl = 'assets/woman3.jpeg';
                        }
                        return CardWidget(
                          title: "Session ${index + 1}",
                          height: 170.0,
                          width: 100.0,
                          time: "",
                          imageUrl: assetUrl,
                        );
                      })),
                ),
                SizedBoxWidget.box(45.0)
              ]),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .68,
              child: Center(
                  child: RoundButton(
                title: "Start Session",
                width: 320,
                onPress: () {
                  if (kDebugMode) {
                    print("Clicked");
                  }
                  databaseRef1.child("$day-${now.month}-${now.year}").update(
                      {now2: "Example${now.microsecond}"}).then((value) {
                    Utils.flushBarErrorMessage("Added Session", context,
                        color: Constants.blueColor);
                  }).catchError((error, stackTrace) {
                    if (kDebugMode) {
                      print(error.toString());
                    }
                    Utils.flushBarErrorMessage(
                        error.message.toString(), context);
                  });
                },
                buttonColor: Constants.blueColor,
              )),
            )
          ],
        ),
      ),
    );
  }

  list(String title, subtitle) {
    return ListTile(
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'assets/pic1.png',
          )),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Text("View Results"),
    );
  }
}
