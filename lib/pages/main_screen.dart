import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/pages/home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  List<Widget> Pages = [
    Home(),
    Center(child: Text("Reels")),
    Center(child: Text("messeges")),
    Center(child: Text("Search")),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xff121212),
        items: [
          BottomNavigationBarItem(
            icon: Icon(currentIndex == 0 ? CupertinoIcons.house_fill : CupertinoIcons.house, size: 25),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 1 ? CupertinoIcons.play_rectangle_fill : CupertinoIcons.play_rectangle,
              size: 25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(currentIndex == 2 ? CupertinoIcons.paperplane_fill : CupertinoIcons.paperplane, size: 25),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search, size: 25), label: ''),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled, size: 25), label: ''),
        ],
      ),
    );
  }
}
