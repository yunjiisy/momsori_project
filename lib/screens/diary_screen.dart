import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:momsori/getx_controller/diary_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:momsori/screens/diary_edit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:momsori/getx_controller/user_controller.dart';
import 'package:momsori/getx_controller/diary_controller.dart';

class DiaryScreen extends StatefulWidget {
  @override
  DiaryScreenState createState() => DiaryScreenState();
}

class DiaryScreenState extends State<DiaryScreen> {
  //event
  // Map<DateTime, List<Event>> selectedEvents;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  var today = DateTime.now().toString().split(' ')[0].split('-');

  TextEditingController eventController = TextEditingController();
  CalendarBuilders calendarBuilders = CalendarBuilders();
  final diaryController = Get.put(DiaryController());

  //late Map<DateTime, List> events;
  //late Map<DateTime, List> health;
  //late Map<DateTime, List> diarytext;
  //late Map<DateTime, List> feeling;

  late List<dynamic> _selectedEvents;

  List<dynamic> getEventsForDays(DateTime day) {
    return diaryController.events[day] ?? [];
  }

  @override
  void initState() {
    //event
    super.initState();

    calendarBuilders = CalendarBuilders();

    //diaryController.events[selectedDay]![0] = 0xffffffff;
    diaryController.events = {};
    diaryController.health = {};
    diaryController.feeling = {};
    diaryController.diarytext = {};
    _selectedEvents = [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final diaryController = Get.put(DiaryController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
        padding: EdgeInsets.fromLTRB(
            width * 0.03, height * 0.014, width * 0.03, height * 0.014),
        child: GetBuilder<DiaryController>(
          // init 부분 삭제.
          builder: (_) => ListView(
            children: <Widget>[
              Container(
                child: Row(
                  children: [
                    Text(
                      '다이어리',
                      style: TextStyle(
                          fontSize: width * 0.061, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.014),
              Container(
                padding: EdgeInsets.all(height * 0.00146),
                child: Row(
                  children: [
                    Text(
                      today[0] +
                          '.' +
                          today[1] +
                          '.' +
                          today[2] +
                          ' 출산예정 / ' +
                          'd_120 / ' +
                          '32주차',
                      style: TextStyle(fontSize: width * 0.039),
                    ),
                  ],
                ),
              ),
              Container(
                child: TableCalendar(
                  daysOfWeekHeight: height * 0.036,
                  rowHeight: height * 0.0877,
                  //locale: 'ko-KR',
                  focusedDay: DateTime.now(),
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2050),
                  headerStyle: HeaderStyle(
                    headerMargin: EdgeInsets.only(
                        left: width * 0.097,
                        top: height * 0.007,
                        right: width * 0.097,
                        bottom: height * 0.007),
                    titleCentered: true,
                    formatButtonVisible: false,
                    leftChevronIcon: Icon(Icons.arrow_left),
                    rightChevronIcon: Icon(Icons.arrow_right),
                    titleTextStyle: TextStyle(fontSize: width * 0.041),
                  ),
                  calendarStyle: CalendarStyle(
                    todayTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    todayDecoration: BoxDecoration(
                        color: Colors.pink[100], shape: BoxShape.circle),
                    outsideDaysVisible: true,
                    isTodayHighlighted: true,
                    weekendTextStyle: TextStyle().copyWith(color: Colors.red),
                    holidayTextStyle:
                        TextStyle().copyWith(color: Colors.blue[800]),
                    selectedTextStyle: TextStyle(color: Colors.white),
                    selectedDecoration: BoxDecoration(
                      color: Colors.grey[500],
                      shape: BoxShape.circle,
                    ),
                    markersAutoAligned: false,
                    markersAlignment: Alignment.center,
                    markerMargin:
                        EdgeInsets.symmetric(horizontal: 1, vertical: 0),
                  ),

                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(selectedDay, date);
                  },

                  calendarBuilders: makemarkerbuilder(diaryController.events),

                  eventLoader: getEventsForDays,

                  onDaySelected: (DateTime selectDay, DateTime focusDay) {
                    setState(() {
                      var year = focusDay.year;
                      var month = selectDay.month;
                      var day = selectDay.day;
                      var week = selectDay.weekday;
                      selectedDay = selectDay;
                      focusedDay = focusDay;

                      _selectedEvents = getEventsForDays(selectedDay);
                      int colors;
                      if (diaryController.events[selectDay] == null) {
                        colors = 0xffffffff;
                        // colors = 0xFFF2CDCA;
                      } else {
                        colors = diaryController.events[selectDay]![0];
                      }

                      List<int> h = List.filled(14, 15, growable: true);
                      //List<int> h = [];
                      var healthText = List<String>.filled(16, ' ');
                      var healthIcon =
                          List<String>.filled(16, 'assets/icons/No_image.svg');
                      if (diaryController.health[selectDay] == null) {
                        healthIcon[0] = 'assets/icons/No_image.svg';
                        healthText[0] = ' ';
                      } else {
                        int a = 0;
                        for (int i = 0;
                            i < diaryController.health[selectedDay]!.length;
                            i += 2) {
                          healthIcon[a] =
                              diaryController.health[selectedDay]![i];
                          healthText[a] =
                              diaryController.health[selectedDay]![i + 1];
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

                      Get.bottomSheet(GetBuilder<DiaryController>(builder: (_) {
                        return Container(
                          height: height * 0.512,
                          child: Container(
                            padding: EdgeInsets.only(top: height * 0.0146),
                            //color: Colors.white,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0))),
                            child: ListView(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: width * 0.0486),
                                      child: Text(
                                        '$year.$month.$day (32주차)',
                                        style: TextStyle(
                                            fontSize: width * 0.0486,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        padding: EdgeInsets.only(
                                            right: width * 0.024),
                                        icon: Icon(
                                          Icons.close,
                                          size: width * 0.073,
                                        ),
                                        onPressed: () {},
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
                                          )
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
                                              Icon(
                                                Icons.circle,
                                                color: Color(colors),
                                                size: width * 0.09,
                                              ),
                                              Text(
                                                Feeling,
                                                style: TextStyle(
                                                    fontSize: width * 0.028,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                  width: width * 0.09,
                                                  height: width * 0.09,
                                                ),
                                                Text(
                                                  healthText[e],
                                                  style: TextStyle(
                                                      fontSize: width * 0.028,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ]);
                                            }).toList()),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 0,
                                            top: height * 0.0146,
                                            right: width * 0.045),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '녹음파일',
                                                  style: TextStyle(
                                                      fontSize: width * 0.036,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * 0.015,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                              fontSize: width *
                                                                  0.024),
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                                            fontSize:
                                                                width * 0.024),
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                            fontSize:
                                                                width * 0.024),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(top: width * 0.024),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '메모',
                                                  style: TextStyle(
                                                      fontSize: width * 0.036,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * 0.012,
                                            ),
                                            Container(
                                                //color: Color(0xFFE5E5E5),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFE5E5E5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0.h),
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
                        );
                      })); //bottom sheet
                    });
                    print(focusedDay);
                    print(selectedDay);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, width * 0.036, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(DiaryEdit(
                          //events = events,
                          //health = health,
                          selectedDay = selectedDay,
                          //feeling = feeling,
                          //sdiarytext = diarytext,
                        ));
                      },
                      child: SvgPicture.asset(
                        'assets/icons/edit button.svg',
                        height: 70.h,
                        width: 70.w,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  dynamic makemarkerbuilder(Map<DateTime, List> events) {
    return CalendarBuilders(singleMarkerBuilder: (
      context,
      date,
      _event,
    ) {
      if (diaryController.health[date] == null) {
        return Container(
          width: 45.w,
          height: 45.h,
          decoration: BoxDecoration(
              //backgroundBlendMode: BlendMode. ,
              color: Color(events[date]![0]),
              // borderRadius: BorderRadius.all(Radius.circular(20)
              // )
              shape: BoxShape.circle),
          child: Center(child: Text(date.day.toString())),
        );
      }

      return Stack(
        children: [
          Container(
            width: 45.w,
            height: 45.h,
            decoration: BoxDecoration(
                //backgroundBlendMode: BlendMode. ,
                color: Color(events[date]![0]),
                // borderRadius: BorderRadius.all(Radius.circular(20)
                // )
                shape: BoxShape.circle),
            child: Center(child: Text(date.day.toString())),
          ),
          Container(
            width: 20.w,
            height: 20.h,
            child: SvgPicture.asset(diaryController.health[date]![0]),
          ),
        ],
      );
    });
  }
}

Widget buildBottomSheet(BuildContext context) {
  return Container();
}
