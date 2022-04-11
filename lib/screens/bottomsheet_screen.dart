import 'package:flutter/material.dart';
import 'package:momsori/screens/diary_edit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:momsori/getx_controller/diary_controller.dart';
import 'package:dotted_line/dotted_line.dart';

void bottomSheet(DateTime selectDay, DateTime focusDay, final diaryController,
    BuildContext context, DateTime selectedDay, DateTime focusedDay) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  var year = focusDay.year;
  var month = selectDay.month;
  var day = selectDay.day;
  var week = selectDay.weekday;

  String colors;
  if (diaryController.events[selectDay] == null) {
    colors = 'assets/icons/No_image.svg';
  } else {
    colors = diaryController.events[selectDay]![0];
  }

  List<int> h = List.filled(14, 15, growable: true);
  //List<int> h = [];
  var healthText = List<String>.filled(16, ' ');
  var healthIcon = List<String>.filled(16, 'assets/icons/No_image.svg');
  if (diaryController.health[selectDay] == null) {
    healthIcon[0] = 'assets/icons/No_image.svg';
    healthText[0] = ' ';
  } else {
    int a = 0;
    for (int i = 0; i < diaryController.health[selectedDay]!.length; i += 2) {
      healthIcon[a] = diaryController.health[selectedDay]![i];
      healthText[a] = diaryController.health[selectedDay]![i + 1];
      print(healthText[a]);
      h[a] = a;
      a++;
    }
  }

  String diaryText;
  if (diaryController.diarytext[selectDay] == null) {
    diaryText = ' ';
  } else {
    diaryText = diaryController.diarytext[selectedDay]![0];
  }
  String Feeling;
  if (diaryController.feeling[selectDay] == null) {
    Feeling = ' ';
  } else {
    Feeling = diaryController.feeling[selectedDay]![0];
  }
  if (diaryController.events[selectDay] == null &&
      diaryController.health[selectDay] == null &&
      diaryController.diarytext[selectDay] == null) {
    Get.to(DiaryEdit(
      //events = events,
      //health = health,
      selectedDay = selectedDay,
      //feeling = feeling,
      //sdiarytext = diarytext,
    ));
  } else {
    Get.bottomSheet(GetBuilder<DiaryController>(builder: (_) {
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(),
            height: height * 0.452,
            child: Container(
              padding: EdgeInsets.only(top: height * 0.0146),
              //color: Colors.white,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
                color: Colors.white,
              ),
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(10.0),
              //     topRight: Radius.circular(10.0))),
              child: ListView(
                //scrollDirection: Axis.vertical,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: width * 0.0486),
                        child: Text(
                          '$year.$month.$day (32주차)',
                          style: TextStyle(
                              fontSize: width * 0.0486,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          padding: EdgeInsets.only(right: width * 0.024),
                          icon: Icon(
                            Icons.close,
                            size: width * 0.073,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: width * 0.05,
                        top: 0.007,
                        right: width * 0.05,
                        bottom: height * 0.315),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '감정상태/건강상태 ',
                              style: TextStyle(
                                  fontSize: width * 0.036,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              width: width * 0.57,
                              //height: 5.0,
                              child: DottedLine(
                                dashColor: Color(0XFFF2F2F2),
                                dashLength: 7.0,
                                lineThickness: 3.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Row(
                          children: [
                            //for (int i = 0; i < healthIcon.length;i++){}
                            Column(
                              children: [
                                SvgPicture.asset(
                                  colors,
                                  width: width * 0.13,
                                  height: width * 0.13,
                                ),
                                Text(
                                  Feeling,
                                  style: TextStyle(
                                      fontSize: width * 0.028,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Container(
                          width: double.infinity,
                          child: Wrap(
                              spacing: 10,
                              children: h.map((e) {
                                return Column(children: [
                                  SvgPicture.asset(
                                    healthIcon[e],
                                    width: width * 0.13,
                                    height: width * 0.09,
                                  ),
                                  Text(
                                    healthText[e],
                                    style: TextStyle(
                                        fontSize: width * 0.028,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ]);
                              }).toList()),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '녹음파일',
                                    style: TextStyle(
                                        fontSize: width * 0.036,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Container(
                                    width: width * 0.73,
                                    //height: 5.0,
                                    child: DottedLine(
                                      dashColor: Color(0XFFF2F2F2),
                                      dashLength: 7.0,
                                      lineThickness: 3.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.015,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 0,
                                    top: height * 0.0146,
                                    right: width * 0.045),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/play_arrow-24px_3.svg',
                                            width: width * 0.087,
                                          ),
                                          Container(
                                            width: width * 0.243,
                                            child: Text(
                                              '열자를 넘게하면 이렇게 됨!',
                                              style: TextStyle(
                                                  fontSize: width * 0.024),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/play_arrow-24px_3.svg',
                                          width: width * 0.087,
                                        ),
                                        Container(
                                          width: width * 0.243,
                                          child: Text(
                                            '열자를 넘게하면 이렇게 됨!',
                                            style: TextStyle(
                                                fontSize: width * 0.024),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/play_arrow-24px_3.svg',
                                          width: width * 0.087,
                                        ),
                                        Container(
                                          width: width * 0.243,
                                          child: Text(
                                            '열자를 넘게하면 이렇게 됨!',
                                            style: TextStyle(
                                                fontSize: width * 0.024),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: width * 0.024),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '메모',
                                    style: TextStyle(
                                        fontSize: width * 0.036,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Container(
                                    width: width * 0.8,
                                    //height: 5.0,
                                    child: DottedLine(
                                      dashColor: Color(0XFFF2F2F2),
                                      dashLength: 7.0,
                                      lineThickness: 3.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.018,
                              ),
                              Container(
                                  //color: Color(0xFFE5E5E5),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFE5E5E5),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0.h),
                                    child: Text(
                                      diaryText,
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }));
  } //bottom sheet

  // print(focusedDay);
  // print(selectedDay);
}
