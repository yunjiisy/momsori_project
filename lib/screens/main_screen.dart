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
                      height: 90,
                      width: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _selectedIndex == 0
                              ? SvgPicture.asset(
                                  'assets/icons/home_pink.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/home_gray.svg',
                                ),
                          SizedBox(
                            height: 3.h,
                          ),
                          _selectedIndex == 0
                              ? Text(
                                  ' 홈',
                                  style: TextStyle(
                                      color: Colors.pink, fontSize: 7.h),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  ' 홈',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 7.h),
                                  textAlign: TextAlign.center,
                                )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: Container(
                      height: 90,
                      width: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _selectedIndex == 1
                              ? SvgPicture.asset(
                                  'assets/icons/diary_pink.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/diary_gray.svg',
                                ),
                          SizedBox(
                            height: 3.h,
                          ),
                          _selectedIndex == 1
                              ? Text(
                                  ' 다이어리',
                                  style: TextStyle(
                                      color: Colors.pink, fontSize: 7.h),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  ' 다이어리',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 7.h),
                                  textAlign: TextAlign.center,
                                )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  child: Container(
                      height: 90,
                      width: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _selectedIndex == 2
                              ? SvgPicture.asset(
                                  'assets/icons/storage_pink.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/storage_gray.svg',
                                ),
                          SizedBox(
                            height: 3.h,
                          ),
                          _selectedIndex == 2
                              ? Text(
                                  ' 음성일기보관함',
                                  style: TextStyle(
                                      color: Colors.pink, fontSize: 7.h),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  ' 음성일기보관함',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 7.h),
                                  textAlign: TextAlign.center,
                                )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  child: Container(
                      height: 90,
                      width: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _selectedIndex == 3
                              ? SvgPicture.asset(
                                  'assets/icons/t_pink.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/t_gray.svg',
                                ),
                          SizedBox(
                            height: 3.h,
                          ),
                          _selectedIndex == 3
                              ? Text(
                                  ' 태담가이드',
                                  style: TextStyle(
                                      color: Colors.pink, fontSize: 7.h),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  ' 태담가이드',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 7.h),
                                  textAlign: TextAlign.center,
                                )
                        ],
                      )),
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
