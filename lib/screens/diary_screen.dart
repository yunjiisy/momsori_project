import 'package:flutter/material.dart';
import 'package:flutter_svg/parser.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:momsori/screens/diary_edit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:momsori/getx_controller/user_controller.dart';
import 'package:momsori/getx_controller/diary_controller.dart';
import 'package:dotted_line/dotted_line.dart';

class DiaryScreen extends StatefulWidget {
  @override
  DiaryScreenState createState() => DiaryScreenState();
}

class DiaryScreenState extends State<DiaryScreen> {
  //event
  // Map<DateTime, List<Event>> selectedEvents;
  final user = Get.find<UserController>();
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

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/background/calendar_background.jpeg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
            padding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.014, width * 0.05, 0.0),
            child: GetBuilder<DiaryController>(
              // init 부분 삭제.
              builder: (_) => ListView(
                children: <Widget>[
                  SizedBox(
                    height: 70.h,
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.032,
                        ),
                        Text(
                          '다이어리',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.06,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.061),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15.h),
                        //child: Image.asset('assets/images/건강태동.png'),
                        //child: SvgPicture.asset('assets/images/건강배당김.svg'),
                        child: SvgPicture.asset('assets/icons/mymenu.svg'),
                        height: 40.h,
                        width: 40.h,
                      ),
                      Container(
                        padding: EdgeInsets.all(height * 0.003),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.04,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${user.babyNickname}  ' +
                                      'D-' +
                                      '${user.babyDay()}',
                                  style: TextStyle(
                                      fontSize: width * 0.042,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('출산예정일: ' + '${user.babyBirth}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                    child: Container(
                      child: TableCalendar(
                        //pageJumpingEnabled: true,
                        daysOfWeekHeight: height * 0.026,
                        //rowHeight: height * 0.0877,
                        rowHeight: height * 0.067,
                        //locale: 'ko-KR',
                        focusedDay: DateTime.now(),
                        firstDay: DateTime(2000),
                        lastDay: DateTime(2050),
                        headerStyle: HeaderStyle(
                          headerMargin: EdgeInsets.only(
                              left: width * 0.0,
                              top: height * 0.002,
                              right: width * 0.0,
                              bottom: height * 0.0),
                          titleCentered: true,
                          formatButtonVisible: false,
                          // leftChevronIcon: Icon(Icons.arrow_left),
                          // rightChevronIcon: Icon(Icons.arrow_right),
                          titleTextStyle: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                        calendarStyle: CalendarStyle(
                          defaultTextStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.w900, color: Colors.white),
                          todayDecoration: BoxDecoration(boxShadow: [
                            BoxShadow(blurRadius: 3.0, color: Colors.grey)
                          ], color: Color(0XFF3F3A5E), shape: BoxShape.circle),
                          outsideDaysVisible: false,
                          isTodayHighlighted: true,
                          weekendTextStyle:
                              TextStyle().copyWith(color: Colors.red),
                          holidayTextStyle:
                              TextStyle().copyWith(color: Colors.blue[800]),
                          selectedTextStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          selectedDecoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(blurRadius: 3.0, color: Colors.grey)
                            ],
                            color: Color(0XFFFFD1D1),
                            shape: BoxShape.circle,
                          ),
                          markersAutoAligned: false,
                          markersAlignment: Alignment.center,
                          markerMargin:
                              EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                        ),

                        selectedDayPredicate: (DateTime date) {
                          if (selectedDay == DateTime.now()) {
                            return false;
                          } else
                            return isSameDay(selectedDay, date);
                        },

                        calendarBuilders:
                            makemarkerbuilder(diaryController.events),

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
                            String colors;
                            if (diaryController.events[selectDay] == null) {
                              colors = 'assets/icons/No_image.svg';
                            } else {
                              colors = diaryController.events[selectDay]![0];
                            }

                            List<int> h = List.filled(14, 15, growable: true);
                            //List<int> h = [];
                            var healthText = List<String>.filled(16, ' ');
                            var healthIcon = List<String>.filled(
                                16, 'assets/icons/No_image.svg');
                            if (diaryController.health[selectDay] == null) {
                              healthIcon[0] = 'assets/icons/No_image.svg';
                              healthText[0] = ' ';
                            } else {
                              int a = 0;
                              for (int i = 0;
                                  i <
                                      diaryController
                                          .health[selectedDay]!.length;
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
                              diaryText =
                                  diaryController.diarytext[selectedDay]![0];
                            }
                            String Feeling;
                            if (diaryController.feeling[selectDay] == null) {
                              Feeling = ' ';
                            } else {
                              Feeling =
                                  diaryController.feeling[selectedDay]![0];
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
                              Get.bottomSheet(
                                  GetBuilder<DiaryController>(builder: (_) {
                                return Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(),
                                      height: height * 0.452,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: height * 0.0146),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.0486),
                                                  child: Text(
                                                    '$year.$month.$day (32주차)',
                                                    style: TextStyle(
                                                        fontSize:
                                                            width * 0.0486,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                            fontSize:
                                                                width * 0.036,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Container(
                                                        width: width * 0.57,
                                                        //height: 5.0,
                                                        child: DottedLine(
                                                          dashColor:
                                                              Color(0XFFF2F2F2),
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
                                                            height:
                                                                width * 0.13,
                                                          ),
                                                          Text(
                                                            Feeling,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.028,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
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
                                                          return Column(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  healthIcon[e],
                                                                  width: width *
                                                                      0.13,
                                                                  height:
                                                                      width *
                                                                          0.09,
                                                                ),
                                                                Text(
                                                                  healthText[e],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.028,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
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
                                                                  fontSize:
                                                                      width *
                                                                          0.036,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 5.0,
                                                            ),
                                                            Container(
                                                              width:
                                                                  width * 0.73,
                                                              //height: 5.0,
                                                              child: DottedLine(
                                                                dashColor: Color(
                                                                    0XFFF2F2F2),
                                                                dashLength: 7.0,
                                                                lineThickness:
                                                                    3.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 0,
                                                                  top: height *
                                                                      0.0146,
                                                                  right: width *
                                                                      0.045),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {},
                                                                child: Column(
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                      'assets/icons/play_arrow-24px_3.svg',
                                                                      width: width *
                                                                          0.087,
                                                                    ),
                                                                    Container(
                                                                      width: width *
                                                                          0.243,
                                                                      child:
                                                                          Text(
                                                                        '열자를 넘게하면 이렇게 됨!',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                width * 0.024),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Column(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/icons/play_arrow-24px_3.svg',
                                                                    width: width *
                                                                        0.087,
                                                                  ),
                                                                  Container(
                                                                    width: width *
                                                                        0.243,
                                                                    child: Text(
                                                                      '열자를 넘게하면 이렇게 됨!',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              width * 0.024),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/icons/play_arrow-24px_3.svg',
                                                                    width: width *
                                                                        0.087,
                                                                  ),
                                                                  Container(
                                                                    width: width *
                                                                        0.243,
                                                                    child: Text(
                                                                      '열자를 넘게하면 이렇게 됨!',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              width * 0.024),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
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
                                                    padding: EdgeInsets.only(
                                                        top: width * 0.024),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '메모',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      width *
                                                                          0.036,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 5.0,
                                                            ),
                                                            Container(
                                                              width:
                                                                  width * 0.8,
                                                              //height: 5.0,
                                                              child: DottedLine(
                                                                dashColor: Color(
                                                                    0XFFF2F2F2),
                                                                dashLength: 7.0,
                                                                lineThickness:
                                                                    3.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.018,
                                                        ),
                                                        Container(
                                                            //color: Color(0xFFE5E5E5),
                                                            width:
                                                                double.infinity,
                                                            decoration: BoxDecoration(
                                                                color: Color(
                                                                    0xFFE5E5E5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0
                                                                          .h),
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
                          });
                          // print(focusedDay);
                          // print(selectedDay);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0.h, 25.h, 0),
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
                            "assets/icons/편집.svg",
                            height: 60.h,
                            width: 60.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  dynamic makemarkerbuilder(Map<DateTime, List> events) {
    return CalendarBuilders(singleMarkerBuilder: (
      context,
      date,
      _event,
    ) {
      // if (diaryController.events[date] == null) {
      //   diaryController.events[date] = [0xFFFFFFFF];
      //   print('1');
      // }
      // if (diaryController.health[date]![0] == null) {
      //   diaryController.health[date]![0] = 'assets/icons/No_image.svg';
      //   print('2');
      // }
      // if (diaryController.diarytext[date] == null) {
      //   diaryController.diarytext[date]![0] = ' ';
      //   print('3');
      // }
      print('-----------');
      print(date);
      print(diaryController.health[date]);
      print('-------');
      if (diaryController.events[date] != null ||
          diaryController.health[date] != null ||
          diaryController.diarytext[date] != null) {
        print(date);
        print("웨안대");
        print('건강');
        print(diaryController.health[date]);

        print('감정');
        print(diaryController.events[date]);

        return Padding(
          padding: const EdgeInsets.only(top: 33.0),
          child: Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: Color.fromARGB(255, 204, 187, 187)),

                //backgroundBlendMode: BlendMode. ,
                color: Color(0XFFFFD1D1),
                // borderRadius: BorderRadius.all(Radius.circular(20)
                // )
                shape: BoxShape.circle),
            //child: Center(child: Text(date.day.toString())),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(

                //backgroundBlendMode: BlendMode. ,
                color: Colors.white,
                // borderRadius: BorderRadius.all(Radius.circular(20)
                // )
                shape: BoxShape.circle),
            //child: Center(child: Text(date.day.toString())),
          ),
        );
      }

      // if (diaryController.health[date] == null) {
      //   return Container(
      //     width: 45.w,
      //     height: 45.h,
      //     decoration: BoxDecoration(
      //         //backgroundBlendMode: BlendMode. ,
      //         color: Color(events[date]![0]),
      //         // borderRadius: BorderRadius.all(Radius.circular(20)
      //         // )
      //         shape: BoxShape.circle),
      //     child: Center(child: Text(date.day.toString())),
      //   );
      // }

      // return Stack(
      //   children: [
      //     Container(
      //       width: 45.w,
      //       height: 45.h,
      //       decoration: BoxDecoration(
      //           //backgroundBlendMode: BlendMode. ,
      //           color: Color(events[date]![0]),
      //           // borderRadius: BorderRadius.all(Radius.circular(20)
      //           // )
      //           shape: BoxShape.circle),
      //       child: Center(child: Text(date.day.toString())),
      //     ),
      //     Container(
      //       width: 20.w,
      //       height: 20.h,
      //       child: SvgPicture.asset(diaryController.health[date]![0]),
      //     ),
      //   ],
      // );
    });
  }
}

Widget buildBottomSheet(BuildContext context) {
  return Container();
}
