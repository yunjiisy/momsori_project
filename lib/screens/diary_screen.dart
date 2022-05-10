import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:momsori/screens/bottomsheet_screen.dart';
import 'package:momsori/screens/category_screen.dart';
import 'package:momsori/widgets/notifiers/play_button_notifier.dart';
import 'package:momsori/widgets/notifiers/repeat_button_notifier.dart';
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

class DiaryScreenState extends State<DiaryScreen>
    with AutomaticKeepAliveClientMixin<DiaryScreen> {
  //event
  // Map<DateTime, List<Event>> selectedEvents;
  @override
  bool get wantKeepAlive => true;

  final player = AudioPlayer();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final playButtonNotifier = PlayButtonNotifier();
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final progressNotifier = ValueNotifier<ProgressBarState>(ProgressBarState(
    current: Duration.zero,
    total: Duration.zero,
    buffered: Duration.zero,
  ));

  _init() async {
    _listenForChangesInPlayerState();
    _listenForChangesInSequenceState();
    _listenForChangesInPlayerPosition();
    _listenForChangesInBufferedPosition();
    _listenForChangesInTotalDuration();
  }

  _listenForChangesInPlayerState() {
    player.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        player.seek(Duration.zero);
        player.pause();
      }
    });
  }

  _listenForChangesInPlayerPosition() {
    player.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  _listenForChangesInBufferedPosition() {
    player.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
  }

  _listenForChangesInTotalDuration() {
    player.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  _listenForChangesInSequenceState() {
    player.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;

      // update current song title
      final currentItem = sequenceState.currentSource;
      final title = currentItem?.tag as String?;
      currentSongTitleNotifier.value = title ?? '';

      // update playlist
      final playlist = sequenceState.effectiveSequence;
      final titles = playlist.map((item) => item.tag as String).toList();
      playlistNotifier.value = titles;

      // update shuffle mode
      isShuffleModeEnabledNotifier.value = sequenceState.shuffleModeEnabled;

      // update previous and next buttons
      if (playlist.isEmpty || currentItem == null) {
        isFirstSongNotifier.value = true;
        isLastSongNotifier.value = true;
      } else {
        isFirstSongNotifier.value = playlist.first == currentItem;
        isLastSongNotifier.value = playlist.last == currentItem;
      }
    });
  }

  final user = Get.find<UserController>();
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  var today = DateTime.now().toString().split(' ')[0].split('-');

  TextEditingController eventController = TextEditingController();
  CalendarBuilders calendarBuilders = CalendarBuilders();
  final diaryController = Get.put(DiaryController());

  //late Map<DateTime, List> events;
  //late Map<DateTime, List> health;
  //late Map<DateTime, List> diaryText;
  //late Map<DateTime, List> feeling;

  late List<dynamic> _selectedEvents;

  List<dynamic> getEventsForDays(DateTime day) {
    return diaryController.events[day] ?? [];
  }

  @override
  void initState() {
    //event
    super.initState();
    _init();

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
    super.build(context);
    final diaryController = Get.put(DiaryController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image:
                  AssetImage('assets/background/calendar_background2.jpeg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
            padding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.014, width * 0.05, 0.0),
            child: GetBuilder<DiaryController>(
              // init 부분 삭제.
              builder: (_) => SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 56.h,
                    ),
                    Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.042,
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
                    SizedBox(height: height * 0.041),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15.h),
                          //child: Image.asset('assets/images/치골통통.jpeg'),
                          child: Image.asset('assets/icons/메뉴아기.png'),
                          //child: SvgPicture.asset('assets/images/qlqlql.svg'),
                          height: 80.h,
                          width: 80.h,
                        ),
                        Container(
                          padding: EdgeInsets.all(height * 0.003),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${user.babyNickname}  ' +
                                        'D-' +
                                        '${user.babyDay()}',
                                    style: TextStyle(
                                        fontSize: width * 0.048,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text('출산예정일: ' + '${user.babyBirth}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: width * 0.7,
                      //height: 5.0,
                      child: DottedLine(
                        dashColor: Color(0XFFF9F1F1),
                        dashLength: 7.0,
                        lineThickness: 3.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                      child: Container(
                        child: TableCalendar(
                            //pageJumpingEnabled: true,
                            daysOfWeekHeight: height * 0.028,
                            //rowHeight: height * 0.0877,
                            rowHeight: height * 0.062,
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
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                              todayDecoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 3.0, color: Colors.grey)
                                  ],
                                  color: Color(0XFF3F3A5E),
                                  shape: BoxShape.circle),
                              outsideDaysVisible: false,
                              isTodayHighlighted: true,
                              weekendTextStyle:
                                  TextStyle().copyWith(color: Colors.red),
                              holidayTextStyle:
                                  TextStyle().copyWith(color: Colors.blue[800]),
                              selectedTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              selectedDecoration: BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(blurRadius: 3.0, color: Colors.grey)
                                // ],
                                color: Color(0XFFFFD1D1),
                                shape: BoxShape.circle,
                              ),
                              markersAutoAligned: false,
                              markersMaxCount: 1,
                              markersAlignment: Alignment.center,
                              markerMargin: EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 1),
                            ),
                            selectedDayPredicate: (DateTime date) {
                              if (selectedDay == DateTime.now()) {
                                return false;
                              } else
                                return isSameDay(selectedDay, date);
                            },
                            calendarBuilders:
                                makeMarkerBuilder(diaryController.events),
                            eventLoader: getEventsForDays,
                            onDaySelected:
                                (DateTime selectDay, DateTime focusDay) {
                              setState(() {
                                selectedDay = selectDay;
                                focusedDay = focusDay;

                                _selectedEvents = getEventsForDays(selectedDay);
                                bottomSheet(
                                    selectDay,
                                    focusDay,
                                    diaryController,
                                    context,
                                    selectedDay,
                                    focusedDay,
                                    player,
                                    playButtonNotifier);
                              });
                            }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5.h, 25.h, 0),
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
                              height: 55.h,
                              width: 55.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  dynamic makeMarkerBuilder(Map<DateTime, List> events) {
    return CalendarBuilders(singleMarkerBuilder: (
      context,
      date,
      _event,
    ) {
      print(diaryController.health[date]);
      print('-------');
      if (diaryController.events[date] != null ||
          diaryController.health[date] != null ||
          diaryController.diarytext[date] != null) {
        print(date);
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
                    width: 1, color: Color.fromARGB(255, 219, 184, 184)),

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

// Widget buildBottomSheet(BuildContext context) {
//   return Container();
// }
