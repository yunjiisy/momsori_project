// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:momsori/screens/recoder_screen.dart';
import 'package:momsori/widgets/emotion_button.dart';
import 'package:momsori/widgets/health_button.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:momsori/getx_controller/diary_controller.dart';
import 'package:dotted_line/dotted_line.dart';

class DiaryEdit extends StatefulWidget {
  DateTime selectedDay;

  var color;

  var feelingText;

  DiaryEdit(this.selectedDay);

  @override
  DiaryEditState createState() => DiaryEditState();
}

class DiaryEditState extends State<DiaryEdit> {
  var isSelected = <bool>[false, false, false];
  String _year = DateTime.now().year.toString();
  String _month = DateTime.now().month.toString();
  String _day = DateTime.now().day.toString();
  late String healthText;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final diaryController = Get.put(DiaryController());

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    DateTime selectDay = widget.selectedDay;
    _year = selectDay.year.toString();
    _day = selectDay.day.toString();
    _month = selectDay.month.toString();

    final DateTime date = DateTime.now();
    DateTime dateNow = DateTime(date.year, date.month, date.day);
    DateTime dateSelected =
        DateTime(selectDay.year, selectDay.month, selectDay.day);

    bool valDate = widget.selectedDay.isBefore(date);

    if (valDate || dateNow == dateSelected) {
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              '다이어리 등록',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  gradient: LinearGradient(
                      colors: [Color(0XFFFFA9A9), Color(0XFFFFBFAB)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter)),
            ),
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
                print("ㅠㅠㅠ");
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    diaryController.update();
                    Get.back();
                    print(widget.selectedDay.day.toString() + "일 수정 상태");
                    print(diaryController.health[widget.selectedDay]);
                    print(diaryController.events[widget.selectedDay]);
                    print(diaryController.diarytext[widget.selectedDay]);

                    // Get.to(DiaryScreen(

                    // ));
                  },
                  child: Text(
                    '확인',
                    style: TextStyle(
                        fontSize: width * 0.044,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(
                width * 0.024, height * 0.032, width * 0.024, height * 0.007),
            child: ListView(children: [
              Row(
                children: [
                  SizedBox(
                    width: 8.h,
                  ),
                  Text(
                    '$_year년  $_month월  $_day일',
                    style:
                        TextStyle(fontSize: 16.h, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w),
                child: Row(
                  children: [
                    Text(
                      '감정상태',
                      style: TextStyle(
                          fontSize: width * 0.044, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5.h,
                    ),
                    Container(
                      width: 218.h,
                      //height: 5.0,
                      child: DottedLine(
                        lineThickness: 3.0.h,
                        dashColor: Color(0XFFF9F1F1),
                        dashLength: 7.0.h,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    height: 90.0.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      //shrinkWrap: true,
                      children: [
                        new EmotionButton(
                            diaryController.events = diaryController.events,
                            widget.selectedDay = widget.selectedDay,
                            'assets/images/무기력.svg',
                            diaryController.feeling = diaryController.feeling,
                            '무기력'),
                        new EmotionButton(
                            diaryController.events = diaryController.events,
                            widget.selectedDay = widget.selectedDay,
                            'assets/images/분노.svg',
                            diaryController.feeling = diaryController.feeling,
                            "분노"),
                        new EmotionButton(
                            diaryController.events = diaryController.events,
                            widget.selectedDay = widget.selectedDay,
                            'assets/images/예민.svg',
                            diaryController.feeling = diaryController.feeling,
                            "예민"),
                        new EmotionButton(
                            diaryController.events = diaryController.events,
                            widget.selectedDay = widget.selectedDay,
                            'assets/images/감정기복.svg',
                            diaryController.feeling = diaryController.feeling,
                            "감정기복"),
                        new EmotionButton(
                            diaryController.events = diaryController.events,
                            widget.selectedDay = widget.selectedDay,
                            'assets/images/피곤함.svg',
                            diaryController.feeling = diaryController.feeling,
                            "피곤함"),
                        new EmotionButton(
                            diaryController.events = diaryController.events,
                            widget.selectedDay = widget.selectedDay,
                            'assets/images/불안.svg',
                            diaryController.feeling = diaryController.feeling,
                            "불안"),
                        new EmotionButton(
                            diaryController.events = diaryController.events,
                            widget.selectedDay = widget.selectedDay,
                            'assets/images/우울.svg',
                            diaryController.feeling = diaryController.feeling,
                            "우울"),
                        new EmotionButton(
                            diaryController.events = diaryController.events,
                            widget.selectedDay = widget.selectedDay,
                            'assets/images/평온.svg',
                            diaryController.feeling = diaryController.feeling,
                            "평온"),
                        new EmotionButton(
                            diaryController.events = diaryController.events,
                            widget.selectedDay = widget.selectedDay,
                            'assets/images/설레임.svg',
                            diaryController.feeling = diaryController.feeling,
                            "설레임"),
                        new EmotionButton(
                            diaryController.events = diaryController.events,
                            widget.selectedDay = widget.selectedDay,
                            'assets/images/기쁨.svg',
                            diaryController.feeling = diaryController.feeling,
                            "기쁨"),
                        new EmotionButton(
                            diaryController.events = diaryController.events,
                            selectDay = selectDay,
                            'assets/images/활기찬.svg',
                            diaryController.feeling = diaryController.feeling,
                            "활기찬"),
                        new EmotionButton(
                            diaryController.events = diaryController.events,
                            widget.selectedDay = widget.selectedDay,
                            'assets/images/기본.svg',
                            diaryController.feeling = diaryController.feeling,
                            "기본"),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w),
                child: Row(
                  children: [
                    Text(
                      '건강상태',
                      style: TextStyle(
                          fontSize: width * 0.044, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5.0.h,
                    ),
                    Container(
                      width: 218.h,
                      //height: 5.0,
                      child: DottedLine(
                        lineThickness: 3.0.h,
                        dashColor: Color(0XFFF9F1F1),
                        dashLength: 7.0.h,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                height: 90.0.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/괜찮음.svg',
                        healthText = '괜찮음'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/태동.svg',
                        healthText = '태동'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/배뭉침.svg',
                        healthText = '배뭉침'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/배당김.svg',
                        healthText = '배당김'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/복통.svg',
                        healthText = '복통'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/입덧.svg',
                        healthText = '입덧'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/두통.svg',
                        healthText = '두통'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/다리부종.svg',
                        healthText = '다리부종'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/소화불량.svg',
                        healthText = '소화불량'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/변비.svg',
                        healthText = '변비'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/흉통.svg',
                        healthText = '흉통'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/치골통.svg',
                        healthText = '치골통'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/요통.svg',
                        healthText = '요통'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/불면증.svg',
                        healthText = '불면증'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/어지러움.svg',
                        healthText = '어지러움'),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(width * 0.024),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '메모',
                          style: TextStyle(
                              fontSize: width * 0.044,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.0.h,
                        ),
                        Container(
                          width: 240.h,
                          //height: 5.0,
                          child: DottedLine(
                            dashColor: Color(0XFFF9F1F1),
                            lineThickness: 3.0.h,
                            dashLength: 7.0.h,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: width * 0.024,
                    ),
                    Container(
                      child: TextFormField(
                        onChanged: (text) {
                          setState(() {
                            if (diaryController.diarytext[widget.selectedDay] ==
                                null) {
                              diaryController.diarytext[widget.selectedDay] = [
                                ' '
                              ];
                            }
                            if (diaryController.events[widget.selectedDay] ==
                                null) {
                              diaryController.events[widget.selectedDay] = [
                                'assets/icons/No_image.svg'
                              ];
                              diaryController.feeling[widget.selectedDay] = [
                                " "
                              ];
                            }
                            diaryController.diarytext[widget.selectedDay] = [
                              text
                            ];
                          });
                        },
                        textInputAction: TextInputAction.done,
                        //maxLength: 500,
                        keyboardType: TextInputType.multiline,
                        minLines: 6,
                        maxLines: null,
                        cursorColor: Color(0xFFFFA9A9),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(width * 0.027),
                          hintText: "메모를 입력하세요.",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          filled: true,
                          fillColor: Color.fromARGB(255, 236, 236, 236),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(width * 0.024),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '녹음',
                          style: TextStyle(
                              fontSize: width * 0.044,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          width: 240.h,
                          //height: 5.0,
                          child: DottedLine(
                            lineThickness: 3.0,
                            dashColor: Color(0XFFF9F1F1),
                            dashLength: 7.0,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.022,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(RecoderScreen(),
                                transition: Transition.downToUp);
                          },
                          child: SvgPicture.asset(
                            'assets/icons/녹음아이콘.svg',
                            width: width * 0.2,
                            height: width * 0.2,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(RecoderScreen(),
                                transition: Transition.downToUp);
                          },
                          child: SvgPicture.asset(
                            'assets/icons/녹음아이콘.svg',
                            width: width * 0.2,
                            height: width * 0.2,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(RecoderScreen(),
                                transition: Transition.downToUp);
                          },
                          child: SvgPicture.asset(
                            'assets/icons/녹음아이콘.svg',
                            width: width * 0.2,
                            height: width * 0.2,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              '다이어리 등록',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  gradient: LinearGradient(
                      colors: [Color(0XFFFFA9A9), Color(0XFFFFBFAB)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter)),
            ),
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
                print("ㅠㅠㅠ");
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    diaryController.update();
                    Get.back();
                  },
                  child: Text(
                    '확인',
                    style: TextStyle(
                        fontSize: width * 0.044,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(
                width * 0.024, height * 0.032, width * 0.024, height * 0.007),
            child: ListView(children: [
              Row(
                children: [
                  SizedBox(
                    width: 8.h,
                  ),
                  Text(
                    '$_year년  $_month월  $_day일',
                    style:
                        TextStyle(fontSize: 16.h, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(width * 0.024),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '메모',
                          style: TextStyle(
                            fontSize: width * 0.044,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: width * 0.024,
                    ),
                    Container(
                      child: TextFormField(
                        onChanged: (text) {
                          setState(() {
                            if (diaryController.diarytext[widget.selectedDay] ==
                                null) {
                              diaryController.diarytext[widget.selectedDay] = [
                                ' '
                              ];
                            }
                            if (diaryController.events[widget.selectedDay] ==
                                null) {
                              diaryController.events[widget.selectedDay] = [
                                'assets/icons/No_image.svg'
                              ];
                              diaryController.feeling[widget.selectedDay] = [
                                " "
                              ];
                            }
                            diaryController.diarytext[widget.selectedDay] = [
                              text
                            ];
                          });
                        },
                        textInputAction: TextInputAction.done,
                        //maxLength: 500,
                        keyboardType: TextInputType.multiline,
                        minLines: 6,
                        maxLines: null,
                        cursorColor: Color(0xFFFFA9A9),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(width * 0.027),
                          hintText: "메모를 입력하세요.",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          filled: true,
                          fillColor: Color.fromARGB(255, 236, 236, 236),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      );
    }
  }
}
