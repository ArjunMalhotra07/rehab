import 'package:flutter/material.dart';
import 'package:rehab/view/practice_screen.dart';
import 'package:rehab/view/home_page.dart';
import 'package:rehab/view/profile_page.dart';
import 'package:rehab/view/rehab_page.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key, required this.name}) : super(key: key);
  final String? name;
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screens = [
      HomePage(
        name: widget.name,
      ),
      const RehabPage(),
      PracticePage(),
      const ProfilePage()
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text("Main View"),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.green.shade900,
        iconSize: 30,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.data_thresholding_sharp), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.web), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.web), label: "Home"),
        ],
      ),
    );
  }
}
