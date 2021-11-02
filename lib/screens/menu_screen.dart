import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:momsori/screens/profile_screen.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                '내정보',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              height: 0.15 * height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/check.svg',
                    width: 150,
                  ),
                  Container(
                    width: 0.4 * width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('엄마님의 아기'),
                        Text('동동이'),
                        Text('출산예정일: 2021-12-31'),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 50),
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          ProfileScreen(),
                        );
                      },
                      child: Container(
                        height: 30,
                        width: 60,
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
                              fontSize: 20,
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
              color: Colors.grey.withOpacity(0.3),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                '아기관리',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              color: Colors.grey.withOpacity(0.3),
              height: 0.005 * height,
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                '환경설정',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              color: Colors.grey.withOpacity(0.3),
              height: 0.005 * height,
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                '앱관리',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              color: Colors.grey.withOpacity(0.3),
              height: 0.005 * height,
            ),
          ],
        ),
      ),
    );
  }
}
