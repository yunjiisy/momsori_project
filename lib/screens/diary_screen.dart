import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:momsori/screens/diary_edit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  late Map<DateTime, List> events;
  late Map<DateTime, List> health;
  late Map<DateTime, List> diarytext;
  late Map<DateTime, List> feeling;

  late List<dynamic> _selectedEvents;

  List<dynamic> getEventsForDays(DateTime day) {
    return events[day] ?? [];
  }

  @override
  void initState() {
    //event
    super.initState();
    calendarBuilders = CalendarBuilders();
    events = {
      DateTime.utc(2021, 11, 8): [0xFFD3E7E4],
    };
    health = {
      DateTime.utc(2021, 11, 8): ['assets/icons/1.svg', '?????'],
    };
    feeling = {
      DateTime.utc(2021, 11, 8): ['우울'],
    };
    diarytext = {
      DateTime.utc(2021, 11, 8): ['하루종일 비가온다 '],
    };
    _selectedEvents = [DateTime(2021, 11, 8)];
    // edit();
  }

  @override
  void dispose() {
    //  _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          width * 0.03, height * 0.014, width * 0.03, height * 0.014),
      child: ListView(
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
                holidayTextStyle: TextStyle().copyWith(color: Colors.blue[800]),
                selectedTextStyle: TextStyle(color: Colors.white),
                selectedDecoration: BoxDecoration(
                  color: Colors.grey[500],
                  shape: BoxShape.circle,
                ),
                markersAutoAligned: false,
                // markersOffset: PositionedOffset(start:23 , top: 29.0)
                markersAlignment: Alignment.center,
                // markersAlignment: AlignmentGeometry.lerp(
                //     Alignment.center, Alignment.center, 0),
                markerMargin: EdgeInsets.symmetric(horizontal: 1, vertical: 0),
              ),

              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },

              calendarBuilders: makemarkerbuilder(events),

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
                  if (events[selectDay] == null) {
                    colors = 0xffffffff;
                    // colors = 0xFFF2CDCA;
                  } else {
                    colors = events[selectDay]![0];
                  }
                  String healthText;
                  String healthIcon;
                  if (health[selectDay] == null) {
                    healthIcon = 'assets/icons/No_image.svg';
                    healthText = ' ';
                  } else {
                    healthIcon = health[selectedDay]![0];
                    healthText = health[selectedDay]![1];
                  }

                  String diaryText;
                  if (diarytext[selectDay] == null) {
                    diaryText = ' ';
                  } else {
                    diaryText = diarytext[selectedDay]![0];
                  }
                  String Feeling;
                  if (feeling[selectDay] == null) {
                    Feeling = ' ';
                  } else {
                    Feeling = feeling[selectedDay]![0];
                  }

                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0))),
                    backgroundColor: Colors.white,
                    builder: (context) {
                      return Container(
                        height: height * 0.512,
                        child: Container(
                          padding: EdgeInsets.only(top: height * 0.0146),
                          child: ListView(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: width * 0.0486),
                                    // child: Text(
                                    //   today[1] + '/' + today[2],
                                    //   style: TextStyle(
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    child: Text(
                                      '$year.$month.$day (32주차)',
                                      style: TextStyle(
                                          fontSize: width * 0.0486,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    child: IconButton(
                                       padding: EdgeInsets.only(right:width*0.024 ),
                                      icon: Icon(
                                        Icons.close,
                                        size: width*0.073,
                                      ),
                                      onPressed: () {},
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: width*0.05, top: 0.007, right: width*0.05, bottom: height*0.315),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '감정상태/건강상태',
                                          style: TextStyle(
                                              fontSize: width*0.036,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: height*0.015,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Color(colors),
                                              size: width*0.09,
                                            ),
                                            Text(
                                              Feeling,
                                              style: TextStyle(
                                                  fontSize: width*0.028,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width:  height*0.015,
                                        ),
                                        Column(
                                          children: [
                                            SvgPicture.asset(
                                              healthIcon,
                                              width: width*0.09,
                                              height: width*0.09,
                                            ),
                                            Text(
                                              healthText,
                                              style: TextStyle(
                                                  fontSize: width*0.028,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 0, top: height*0.0146, right: width*0.045),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '녹음파일',
                                                style: TextStyle(
                                                    fontSize: width*0.036,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: height*0.015,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/play_arrow-24px_3.svg',
                                                      width: width*0.087,
                                                    ),
                                                    Container(
                                                      width: width*0.243,
                                                      child: Text(
                                                        '열자를 넘게하면 이렇게 됨!',
                                                        style: TextStyle(
                                                            fontSize: width*0.024),
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
                                                    width: width*0.087,
                                                  ),
                                                  Container(
                                                    width: width*0.243,
                                                    child: Text(
                                                      '열자를 넘게하면 이렇게 됨!',
                                                      style: TextStyle(
                                                          fontSize: width*0.024),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/play_arrow-24px_3.svg',
                                                    width: width*0.087,
                                                  ),
                                                  Container(
                                                    width: width*0.243,
                                                    child: Text(
                                                      '열자를 넘게하면 이렇게 됨!',
                                                      style: TextStyle(
                                                          fontSize: width*0.024),
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                      padding: EdgeInsets.only(top: width*0.024),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '메모',
                                                style: TextStyle(
                                                    fontSize: width*0.036,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: height*0.012,
                                          ),
                                          Container(
                                              //color: Color(0xFFE5E5E5),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFE5E5E5),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
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
                    },
                  ); //bottom sheet
                });
                print(focusedDay);
                print(selectedDay);
              },
            ),
          ),
          Padding(
            padding:  EdgeInsets.fromLTRB(0, 0, width*0.036, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    print(height);
                    print(width);
                    print(MediaQuery.of(context).size);
                    final eventsdata = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DiaryEdit(
                                  events = events,
                                  health = health,
                                  selectedDay = selectedDay,
                                  feeling = feeling,
                                  diarytext = diarytext,
                                )));
                    setState(() {
                      events = eventsdata[0];
                      health = eventsdata[1];
                      diarytext = eventsdata[2];
                      feeling = eventsdata[3];
                      selectedDay = eventsdata[4];
                    });
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
    );
  }

  dynamic makemarkerbuilder(Map<DateTime, List> events) {
    return CalendarBuilders(singleMarkerBuilder: (
      context,
      date,
      _event,
    ) {
      // int colors;
      // if (events[date][0] == null) {
      //   //colors = 0xfffffff;
      //   events[date][0] = 0xFFF2CDCA;
      //   print("양아아ㅏ아아앚");
      //   print(events[date]);
      // }

      // if (events[date] == null) {
      //   setState(() {
      //     events[date] = [0xfffffff];
      //   });
      // }
      if (health[date] == null) {
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
            child: SvgPicture.asset(health[date]![0]),
          ),
        ],
      );
    });
  }
}


Widget buildBottomSheet(BuildContext context) {
  return Container();
}
