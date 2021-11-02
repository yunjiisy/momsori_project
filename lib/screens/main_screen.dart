import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:momsori/screens/diary_screen.dart';
import 'package:momsori/screens/home_screen.dart';
import 'package:momsori/screens/storage_screen.dart';

import 'taedam_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  var jsonData;

  @override
  void initState() {
    // jsonData = Get.arguments;
    // user = UserTest.fromJson(jsonData);
    super.initState();
    if (Get.arguments != null) {
      _selectedIndex = Get.arguments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 48.h,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 2,
                  color: Color(0xFFCCCCCC),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    child: _selectedIndex == 0
                        ? SvgPicture.asset(
                            'assets/icons/홈선택.svg',
                          )
                        : SvgPicture.asset(
                            'assets/icons/홈선택x.svg',
                          ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    child: _selectedIndex == 1
                        ? SvgPicture.asset(
                            'assets/icons/달력선택.svg',
                          )
                        : SvgPicture.asset(
                            'assets/icons/달력선택x.svg',
                          ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    child: _selectedIndex == 2
                        ? SvgPicture.asset(
                            'assets/icons/저장선택.svg',
                          )
                        : SvgPicture.asset(
                            'assets/icons/저장선택x.svg',
                          ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    child: _selectedIndex == 3
                        ? SvgPicture.asset(
                            'assets/icons/태담선택.svg',
                          )
                        : SvgPicture.asset(
                            'assets/icons/태담선택x.svg',
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }

  List _widgetOptions = [
    HomeScreen(),
    DiaryScreen(),
    StorageScreen(),
    TaedamScreen(),
  ];
}
