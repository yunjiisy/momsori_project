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
  // DiaryEdit(Map<DateTime, List> events, [DateTime selectedday]);
  //Map<DateTime, List> events;
  DateTime selectedDay;

  //Map<DateTime, List> health;
  //Map<DateTime, List> diarytext;
  //Map<DateTime, List> feeling;

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
  late String healthtext;

  @override
  void initState() {
    // TODO: implement initState
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
    DateTime date_now = DateTime(date.year, date.month, date.day);
    DateTime date_selected =
        DateTime(selectDay.year, selectDay.month, selectDay.day);

    bool valDate = widget.selectedDay.isBefore(date);

    if (valDate || date_now == date_selected) {
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
                diaryController.events.remove(widget.selectedDay);
                diaryController.health.remove(widget.selectedDay);
                diaryController.feeling.remove(widget.selectedDay);
                //widget.health.remove(widget.selectedDay);

                diaryController.update();
                Get.back();
                print("ㅠㅠㅠ");
                print(diaryController.health);
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    // if (diaryController.events[widget.selectedDay] == null) {
                    //   diaryController.events[widget.selectedDay] = [0xffffff];
                    // }

                    // Navigator.pop(context, [
                    //   //widget.events,
                    //   widget.health,
                    //   widget.diarytext,
                    //   widget.feeling,
                    //   widget.selectedDay,
                    // ]);

                    //print(widget.events);
                    diaryController.update();
                    Get.back();
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
                  // Container(
                  //   //width: double.maxFinite,
                  //   width: width * 0.95,
                  //   height: height * 0.073,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       _myDatePicker();
                  //     },
                  //     child: Text(
                  //       '$_year 년 $_month 월 $_day 일',
                  //       // '$widget.selectedDay',
                  //       style: TextStyle(
                  //           fontSize: width * 0.048,
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.black),
                  //     ),
                  //     style: ElevatedButton.styleFrom(
                  //         primary: Colors.white,
                  //         elevation: 0.0,
                  //         side: BorderSide(color: Colors.black)),
                  //   ),
                  // ),
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
                        healthtext = '괜찮음'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/태동.svg',
                        healthtext = '태동'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/배뭉침.svg',
                        healthtext = '배뭉침'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/배당김.svg',
                        healthtext = '배당김'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/복통.svg',
                        healthtext = '복통'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/입덧.svg',
                        healthtext = '입덧'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/두통.svg',
                        healthtext = '두통'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/다리부종.svg',
                        healthtext = '다리부종'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/소화불량.svg',
                        healthtext = '소화불량'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/변비.svg',
                        healthtext = '변비'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/흉통.svg',
                        healthtext = '흉통'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/치골통.svg',
                        healthtext = '치골통'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/요통.svg',
                        healthtext = '요통'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/불면증.svg',
                        healthtext = '불면증'),
                    new HealthButton(
                        diaryController.health = diaryController.health,
                        widget.selectedDay = widget.selectedDay,
                        'assets/images/어지러움.svg',
                        healthtext = '어지러움'),
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
                            if (diaryController.diarytext[selectDay] == null) {
                              diaryController.diarytext[selectDay] = [' '];
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
          appBar: AppBar(
            title: Text(
              '다이어리 등록',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 5.0,
            leading: IconButton(
                onPressed: () {
                  diaryController.events.remove(widget.selectedDay);
                  diaryController.health.remove(widget.selectedDay);
                  //widget.health.remove(widget.selectedDay);

                  Navigator.pop(context, [
                    diaryController.events,
                    diaryController.health,
                    diaryController.diarytext,
                    diaryController.feeling,
                    widget.selectedDay
                  ]);
                  print("ㅠㅠㅠ이벤트");
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            actions: [
              TextButton(
                  onPressed: () {
                    if (diaryController.events[widget.selectedDay] == null) {
                      diaryController.events[widget.selectedDay] = [
                        'assets/icons/No_image.svg'
                      ];
                    }

                    Navigator.pop(context, [
                      //widget.events,
                      //widget.health,
                      //widget.diarytext,
                      diaryController.feeling,
                      widget.selectedDay
                    ]);
                  },
                  child: Text(
                    '확인',
                    style: TextStyle(
                        fontSize: width * 0.044,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(
                width * 0.024, height * 0.007, width * 0.024, height * 0.007),
            child: ListView(children: [
              Row(
                children: [
                  Container(
                    //width: double.maxFinite,
                    width: width * 0.95,
                    height: height * 0.073,
                    child: ElevatedButton(
                      onPressed: () {
                        _myDatePicker();
                      },
                      child: Text(
                        '$_year 년 $_month 월 $_day 일',
                        // '$widget.selectedDay',
                        style: TextStyle(
                            fontSize: width * 0.048,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 0.0,
                          side: BorderSide(color: Colors.black)),
                    ),
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
                            diaryController.diarytext[widget.selectedDay] = [
                              text
                            ];
                          });
                        },
                        textInputAction: TextInputAction.done,
                        maxLength: 500,
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: null,
                        cursorColor: Color(0xFFFFA9A9),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(width * 0.012),
                          hintText: "메모를 입력하세요.",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          filled: true,
                          fillColor: Color(0xFFE5E5E5),
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

  _myDatePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          child: CupertinoDatePicker(
            use24hFormat: true,
            initialDateTime: widget.selectedDay,
            onDateTimeChanged: (DateTime date) {
              var _date =
                  DateFormat('yyyy-MM-dd 00:00:000').format(date).split('-');
              var date1 = DateFormat("yyyy-MM-dd HH:mm:ss.sss'Z'").format(date);
              print("date1은???" + date1);
              date = DateTime.parse(date1);

              //date = DateTime.parse('2020-01-02 03:04:000');

              setState(() {
                print(widget.selectedDay);
                widget.selectedDay = date;
                print(widget.selectedDay);
                _year = _date[0];
                _month = _date[1];
                _day = _date[2];
              });
            },
            minimumYear: 2000,
            maximumYear: 2100,
            mode: CupertinoDatePickerMode.date,
          ),
        );
      },
    );
  }
}
