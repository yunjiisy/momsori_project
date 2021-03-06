import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:momsori/screens/profile_screen.dart';
import 'package:momsori/getx_controller/user_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/contants.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final user = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/background/calendar_image.jpeg')),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //appBar: AppBar(
        // title: Title(color: Colors.black12, child: child),),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w, top: 35.h, right: 15.w),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 50.h,
                        width: 40.w,
                        child: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '내 정보',
                    style: kTitleStyle,
                    // style: kTitleStyle,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.h, left: 10.h),
              height: 0.15 * height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icons/메뉴아기.png',
                    width: 70.h,
                  ),
                  SizedBox(width: width * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 0.029 * height,
                      ),
                      Container(
                        height: 28.h,
                        child: Center(
                          child: Text(
                            '${user.userName}  ' + 'D-' + '${user.babyDay()}',
                            style: TextStyle(
                              fontSize: 0.026 * height,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 16.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '출산예정일 : ${user.babyBirth}   ',
                              style: TextStyle(
                                fontSize: 0.018 * height,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   width: 0.4 * width,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text('엄마님의 아기'),
                  //       Text('동동이'),
                  //       Text('출산예정일: 2021-12-31'),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.only(top: 22.h, left: 20.w),
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          ProfileScreen(),
                        );
                      },
                      child: Container(
                        height: 23.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Color(0xFFFFA9A9),
                        ),
                        child: Center(
                          child: Text(
                            '수정',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 0.01 * height,
              color: Color(0XFFF9F1F1),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        '아기관리',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      color: Colors.grey.withOpacity(0.3),
                      height: 0.002 * height,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        '환경설정',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      color: Colors.grey.withOpacity(0.3),
                      height: 0.002 * height,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        '앱관리',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      color: Colors.grey.withOpacity(0.3),
                      height: 0.002 * height,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
