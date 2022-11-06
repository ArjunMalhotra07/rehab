import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rehab/utils/components/colors.dart';
import 'package:rehab/view/practice_screen.dart';
import 'package:rehab/view/home_page.dart';
import 'package:rehab/view/profile_page.dart';
import 'package:rehab/view/rehab_page.dart';

import '../utils/utils.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
  }

  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    final screens = [
      HomePage(),
      const RehabPage(),
      PracticePage(),
      const ProfilePage()
    ];
    return Scaffold(
      backgroundColor: Constants.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Constants.whiteColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(""),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black45,
          iconSize: 28,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.data_thresholding_sharp), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Rehab"),
            BottomNavigationBarItem(icon: Icon(Icons.web), label: "Practice"),
            BottomNavigationBarItem(icon: Icon(Icons.web), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
