// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables


import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:flutter/material.dart';
// import 'package:posyandu_petugas/pages/Detail.dart';
import 'package:posyandu_petugas/pages/Home.dart';
import 'package:posyandu_petugas/pages/Profile.dart';
import 'package:posyandu_petugas/utils/constans.dart';
// import 'package:posyandu_petugas/utils/core.dart';


class Navigasi extends StatefulWidget {
  const Navigasi({Key? key}) : super(key: key);

  @override
  State<Navigasi> createState() => _NavigasiState();
}

class _NavigasiState extends State<Navigasi> {
  List<ScreenHiddenDrawer> itemList = [];


  final List<ScreenHiddenDrawer> pages = [
    ScreenHiddenDrawer(
      ItemHiddenMenu(
        name: "Home",
        colorLineSelected: primaryGreen,
        baseStyle:
            TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 25.0),
        selectedStyle: const TextStyle(color: Colors.grey),
      ),
      const HomeView(),
    ),
    ScreenHiddenDrawer(
      ItemHiddenMenu(
        name: "Profile",
        colorLineSelected: primaryGreen,
        baseStyle:
            TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 25.0),
        selectedStyle: const TextStyle(color: Colors.grey),
      ),
      const Profile(),
    ),
    // ScreenHiddenDrawer(
    //   ItemHiddenMenu(
    //     name: "Logout",
    //     colorLineSelected: primaryGreen,
    //     baseStyle:TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 25.0),
    //     selectedStyle: const TextStyle(color: Colors.grey),
    //   ),
    //   Modal(content: "keluar ?"),
    // ),
    // ScreenHiddenDrawer(
    //   ItemHiddenMenu(
    //     name: "Screen 2",
    //     colorLineSelected: Colors.orange,
    //     baseStyle:
    //         TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 25.0),
    //     selectedStyle: TextStyle(color: Colors.orange),
    //     onTap: () {
    //       print("Click item");
    //     },
    //   ),
    //   Screen2(),
    // )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   itemList = [
    //     ScreenHiddenDrawer(
    //         ItemHiddenMenu(
    //           name: "detail",
    //           baseStyle: TextStyle(
    //               color: Colors.white.withOpacity(0.8), fontSize: 25.0),
    //           selectedStyle: TextStyle(color: Colors.teal),
    //         ),
    //         HomeView())
    //   ];
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: HiddenDrawerMenu(
        initPositionSelected: 0,
        screens: pages,
        backgroundColorMenu: Colors.blueGrey,
        slidePercent: 50,
      ),
    );


    
  }
}
