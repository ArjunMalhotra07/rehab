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
      debugPrint("Inside Listener");
      for (final child in event.snapshot.children) {
        // Handle the post.
        var dataObject = child.value;
        var key = child.key.toString();
        debugPrint(dataObject.toString());
        debugPrint(key);
      }
      Map dataObject = {
        "5-11-2022": {
          "2:9": "Example728",
          "3:15": "Example644",
          "1:45": "Example",
          "2:11": "Example184",
          "2:7": "Example",
        },
        "6-11-2022": {
          "2:16": "Example440",
          "2:26": "Example124",
          "2:22": "Example515",
        },
      };

      for (MapEntry item in dataObject.entries) {
        String day = item.key.toString();
        debugPrint("day: $day");
        for (MapEntry item2 in dataObject[item.key].entries) {
          String hour = item2.key.toString();
          String value = item2.value.toString();
          debugPrint("hour: $hour value: $value");
        }
      }
      debugPrint("");
    }, onError: (error) {});
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Rehab Programme",
            style: TextStyle(color: Constants.blackColor, fontSize: 30),
          ),
          SizedBoxWidget.box(10.0),
          ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset('assets/doctor.png')),
          SizedBoxWidget.box(10.0),
          Row(
            children: [
              const Text(
                "History",
                style: TextStyle(color: Constants.blackColor, fontSize: 22),
              ),
              const Spacer(),
              Image.asset('assets/funnel.png', height: 30, fit: BoxFit.fill),
            ],
          ),
          SizedBoxWidget.box(5.0),
          Container(
              height: 85,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey.shade400,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 5),
                      Column(
                        children: const [
                          Text(
                            "Total Sessions",
                            style: TextStyle(
                                color: Constants.blackColor, fontSize: 15),
                          ),
                          Text("16")
                        ],
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: 1,
                        height: 25,
                        color: Constants.blackColor,
                      ),
                      SizedBox(width: 5),
                      Column(
                        children: const [
                          Text(
                            "Total time",
                            style: TextStyle(
                                color: Constants.blackColor, fontSize: 15),
                          ),
                          Text("16")
                        ],
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
              )),
          SizedBoxWidget.box(30.0),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: ((context, snapshot, animation, index) {
                  // var object = (snapshot.children)[index];
                  var object = snapshot.children;
                  var length = object.length;
                  var key = snapshot.key;

                  debugPrint("$length");
                  debugPrint(object.toString());
                  debugPrint(key.toString());

                  for (final jsonObject in snapshot.children) {
                    var subJson = snapshot.children.first;
                    debugPrint(subJson.key);
                    debugPrint(subJson.value.toString());
                    return Column(
                      children: [
                        ListTile(
                          leading: Image.asset('assets/pic1.png'),
                          title: Text(snapshot.key.toString()),
                          subtitle: Text(subJson.key.toString()),
                        ),
                        SizedBoxWidget.box(15.0)
                      ],
                    );
                  }
                  return Container();
                })),
          )
        ],
      ),
    );
  }
}
