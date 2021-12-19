import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:momsori/screens/recoder_screen.dart';
import 'package:momsori/widgets/emotion_button.dart';
import 'package:momsori/widgets/health_button.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiaryEdit extends StatefulWidget {
  // DiaryEdit(Map<DateTime, List> events, [DateTime selectedday]);
  Map<DateTime, List> events;
  DateTime selectedDay;

  Map<DateTime, List> health;
  Map<DateTime, List> diarytext;
  Map<DateTime, List> feeling;

  DiaryEdit(
      this.events, this.health, this.selectedDay, this.feeling, this.diarytext);

  @override
  DiaryEditState createState() => DiaryEditState();
}

class DiaryEditState extends State<DiaryEdit> {
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
          appBar: AppBar(
            title: Text(
              '다이어리 등록',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 5.0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                widget.events.remove(widget.selectedDay);
                widget.health.remove(widget.selectedDay);
                //widget.health.remove(widget.selectedDay);

                Navigator.pop(context, [
                  widget.events,
                  widget.health,
                  widget.diarytext,
                  widget.feeling,
                  widget.selectedDay
                ]);
                print("ㅠㅠㅠ이벤트");
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (widget.events[widget.selectedDay] == null) {
                      widget.events[widget.selectedDay] = [0xffffff];
                    }

                    Navigator.pop(context, [
                      widget.events,
                      widget.health,
                      widget.diarytext,
                      widget.feeling,
                      widget.selectedDay
                    ]);

                    print(widget.events);
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
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w),
                child: Row(
                  children: [
                    Text(
                      '감정상태',
                      style: TextStyle(fontSize: width * 0.044),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      new EmotionButton(
                          widget.events = widget.events,
                          widget.selectedDay = widget.selectedDay,
                          0xFFE2EAD2,
                          widget.feeling = widget.feeling,
                          '무기력'),
                      new EmotionButton(
                          widget.events = widget.events,
                          widget.selectedDay = widget.selectedDay,
                          0xFFD3E7E4,
                          widget.feeling = widget.feeling,
                          "분노"),
                      new EmotionButton(
                          widget.events = widget.events,
                          widget.selectedDay = widget.selectedDay,
                          0xFFD3EBF4,
                          widget.feeling = widget.feeling,
                          "예민"),
                      new EmotionButton(
                          widget.events = widget.events,
                          widget.selectedDay = widget.selectedDay,
                          0xFFD6E2F3,
                          widget.feeling = widget.feeling,
                          "감정기복"),
                      new EmotionButton(
                          widget.events = widget.events,
                          widget.selectedDay = widget.selectedDay,
                          0xFFD7D5E4,
                          widget.feeling = widget.feeling,
                          "피곤함"),
                      new EmotionButton(
                          widget.events = widget.events,
                          widget.selectedDay = widget.selectedDay,
                          0xFFD7D5EA,
                          widget.feeling = widget.feeling,
                          "불안"),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.026,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      new EmotionButton(
                          widget.events = widget.events,
                          widget.selectedDay = widget.selectedDay,
                          0xFFECA8C4,
                          widget.feeling = widget.feeling,
                          "우울"),
                      new EmotionButton(
                          widget.events = widget.events,
                          widget.selectedDay = widget.selectedDay,
                          0xFFEFC2D9,
                          widget.feeling = widget.feeling,
                          "평온"),
                      new EmotionButton(
                          widget.events = widget.events,
                          widget.selectedDay = widget.selectedDay,
                          0xFFF2CDCA,
                          widget.feeling = widget.feeling,
                          "설레임"),
                      new EmotionButton(
                          widget.events = widget.events,
                          widget.selectedDay = widget.selectedDay,
                          0xFFF6E1CD,
                          widget.feeling = widget.feeling,
                          "기쁨"),
                      new EmotionButton(
                          widget.events = widget.events,
                          selectDay = selectDay,
                          0xFFFBF4D8,
                          widget.feeling = widget.feeling,
                          "활기찬"),
                      new EmotionButton(
                          widget.events = widget.events,
                          widget.selectedDay = widget.selectedDay,
                          0XFFFFFFFF,
                          widget.feeling = widget.feeling,
                          "기본"),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w),
                child: Row(
                  children: [
                    Text(
                      '건강상태',
                      style: TextStyle(fontSize: width * 0.044),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HealthButton(
                          widget.health = widget.health,
                          widget.selectedDay = widget.selectedDay,
                          'assets/icons/1.svg',
                          healthtext = '괜찮음'),
                      HealthButton(
                          widget.health = widget.health,
                          widget.selectedDay = widget.selectedDay,
                          'assets/icons/Frame 40.svg',
                          healthtext = '태동'),
                      HealthButton(
                          widget.health = widget.health,
                          widget.selectedDay = widget.selectedDay,
                          'assets/icons/Frame 41.svg',
                          healthtext = '배뭉침'),
                      HealthButton(
                          widget.health = widget.health,
                          widget.selectedDay = widget.selectedDay,
                          'assets/icons/Frame 42.svg',
                          healthtext = '배당김'),
                      HealthButton(
                          widget.health = widget.health,
                          widget.selectedDay = widget.selectedDay,
                          'assets/icons/Frame 43.svg',
                          healthtext = '복통'),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.026,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HealthButton(
                          widget.health = widget.health,
                          widget.selectedDay = widget.selectedDay,
                          'assets/icons/Frame 44.svg',
                          healthtext = '입덧'),
                      HealthButton(
                          widget.health = widget.health,
                          widget.selectedDay = widget.selectedDay,
                          'assets/icons/Frame 51.svg',
                          healthtext = '두통'),
                      HealthButton(
                          widget.health = widget.health,
                          widget.selectedDay = widget.selectedDay,
                          'assets/icons/Frame 45.svg',
                          healthtext = '다리부종'),
                      HealthButton(
                          widget.health = widget.health,
                          widget.selectedDay = widget.selectedDay,
                          'assets/icons/Frame 46.svg',
                          healthtext = '소화불량'),
                      HealthButton(
                          widget.health = widget.health,
                          widget.selectedDay = widget.selectedDay,
                          'assets/icons/Frame 47.svg',
                          healthtext = '변비'),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.026,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HealthButton(
                          widget.health = widget.health,
                          widget.selectedDay = widget.selectedDay,
                          'assets/icons/Frame 48.svg',
                          healthtext = '갈비뼈'),
                      HealthButton(
                          widget.health = widget.health,
                          widget.selectedDay = widget.selectedDay,
                          'assets/icons/Frame 48.svg',
                          healthtext = '치골'),
                      HealthButton(
                          widget.health = widget.health,
                          widget.selectedDay = widget.selectedDay,
                          'assets/icons/Frame 48.svg',
                          healthtext = '요통'),
                      HealthButton(
                          widget.health = widget.health,
                          widget.selectedDay = widget.selectedDay,
                          'assets/icons/Frame 52.svg',
                          healthtext = '불면증'),
                      HealthButton(
                          widget.health = widget.health,
                          widget.selectedDay = widget.selectedDay,
                          'assets/icons/Frame 50.svg',
                          healthtext = '어지러움'),
                    ],
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
                            widget.diarytext[widget.selectedDay] = [text];
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
                            'assets/icons/record_ic.svg',
                            width: width * 0.146,
                            height: width * 0.146,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(RecoderScreen(),
                                transition: Transition.downToUp);
                          },
                          child: SvgPicture.asset(
                            'assets/icons/record_ic.svg',
                            width: width * 0.146,
                            height: width * 0.146,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(RecoderScreen(),
                                transition: Transition.downToUp);
                          },
                          child: SvgPicture.asset(
                            'assets/icons/record_ic.svg',
                            width: width * 0.146,
                            height: width * 0.146,
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
                  widget.events.remove(widget.selectedDay);
                  widget.health.remove(widget.selectedDay);
                  //widget.health.remove(widget.selectedDay);

                  Navigator.pop(context, [
                    widget.events,
                    widget.health,
                    widget.diarytext,
                    widget.feeling,
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
                    if (widget.events[widget.selectedDay] == null) {
                      widget.events[widget.selectedDay] = [0xffffff];
                    }

                    Navigator.pop(context, [
                      widget.events,
                      widget.health,
                      widget.diarytext,
                      widget.feeling,
                      widget.selectedDay
                    ]);

                    print(widget.events);
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
                            widget.diarytext[widget.selectedDay] = [text];
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
