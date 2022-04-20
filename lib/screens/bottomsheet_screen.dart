// ignore: unnecessary_import
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:momsori/screens/category_screen.dart';
import 'package:momsori/screens/diary_edit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:momsori/getx_controller/diary_controller.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:momsori/widgets/call_diary_record_list_widget.dart';
import 'package:momsori/widgets/notifiers/play_button_notifier.dart';

void bottomSheet(
    DateTime selectDay,
    DateTime focusDay,
    final diaryController,
    BuildContext context,
    DateTime selectedDay,
    DateTime focusedDay,
    AudioPlayer player) async {
  final playButtonNotifier = PlayButtonNotifier();
  final diaryController = Get.put(DiaryController());
  late ConcatenatingAudioSource _playlist =
      ConcatenatingAudioSource(children: []);

  Future<List<Map>> tmpList = callDiaryRecordListWidget(selectDay);
  List<Map> recordList = await tmpList;
  recordList.forEach((element) {
    print(element);
  });

  void setupFile(int index) async {
    _playlist.add(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.file(recordList[index]["path"]),
          tag: recordList[index]["name"]),
    ]));
    await player.setAudioSource(_playlist);
  }

  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;

  var year = focusDay.year;
  var month = selectDay.month;
  var day = selectDay.day;
  var week = selectDay.weekday;

  var colors;
  print("현재 상태");
  print(diaryController.events[selectDay]);
  print(diaryController.health[selectDay]);

  if (diaryController.events[selectDay] == null) {
    colors = 'assets/icons/No_image.svg';
  } else {
    colors = diaryController.events[selectDay];
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
  late var feeling;

  if (diaryController.feeling[selectDay] == null) {
    feeling = " ";
  } else {
    feeling = diaryController.feeling[selectedDay];
  }
  if ((diaryController.events[selectDay] == null ||
          diaryController.events[selectDay]!.isEmpty == true) &&
      (diaryController.health[selectDay] == null ||
          diaryController.health[selectDay]!.isEmpty == true) &&
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
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(children: [
            Stack(children: [
              Container(
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(220, 255, 149, 149),
                        Color.fromARGB(130, 255, 154, 97),
                      ]),
                  //color: Colors.black,
                ),
              ),
              Positioned(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: width * 0.04),
                      child: Text(
                        '$year.$month.$day (32주차)',
                        style: TextStyle(
                            fontSize: width * 0.0486,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    // SizedBox(
                    //   width: width * 0.41,
                    // ),
                    Container(
                      child: IconButton(
                        padding: EdgeInsets.only(right: width * 0.024),
                        icon: Icon(
                          Icons.close,
                          size: width * 0.073,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    )
                  ],
                ),
              )
            ]),
            Expanded(
              child: ListView(children: [
                Column(children: [
                  Container(
                    margin: EdgeInsets.only(top: height * 0.015),
                    //width: double.infinity,
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
                          height: height * 0.005,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: colors.length,
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      Column(
                                        children: [
                                          SvgPicture.asset(
                                            colors[index],
                                            width: width * 0.13,
                                            height: width * 0.13,
                                          ),
                                          Text(
                                            feeling[index],
                                            style: TextStyle(
                                                fontSize: width * 0.028,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: width * 0.009),
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: healthIcon.length,
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      Column(
                                        children: [
                                          SvgPicture.asset(
                                            healthIcon[index],
                                            width: width * 0.1,
                                            height: width * 0.1,
                                          ),
                                          SizedBox(
                                            height: height * 0.006,
                                          ),
                                          Text(
                                            healthText[index],
                                            style: TextStyle(
                                                fontSize: width * 0.028,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: width * 0.034,
                                      )
                                    ],
                                  )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0.03 * width),
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
                                // margin:
                                //     EdgeInsets.only(left: width * 0.009),
                                width: MediaQuery.of(context).size.width,
                                height: 70,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: recordList.length,
                                    itemBuilder: (context, index) => Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 0.02 * width),
                                              width: width * 0.2,
                                              child: Column(children: [
                                                ValueListenableBuilder<
                                                    ButtonState>(
                                                  valueListenable:
                                                      playButtonNotifier,
                                                  builder: (_, value, __) {
                                                    switch (value) {
                                                      case ButtonState.loading:
                                                        return Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          width: width * 0.087,
                                                          height: width * 0.087,
                                                          child:
                                                              const CircularProgressIndicator(),
                                                        );
                                                      case ButtonState.paused:
                                                        return IconButton(
                                                          icon:
                                                              SvgPicture.asset(
                                                            'assets/icons/play_arrow-24px_3.svg',
                                                            width:
                                                                width * 0.087,
                                                          ),
                                                          iconSize:
                                                              width * 0.087,
                                                          onPressed: () {
                                                            setupFile(index);
                                                            player.play().obs;
                                                          },
                                                        );
                                                      case ButtonState.playing:
                                                        return IconButton(
                                                          icon: const Icon(
                                                              Icons.pause),
                                                          iconSize:
                                                              width * 0.087,
                                                          onPressed: () {
                                                            player.pause().obs;
                                                          },
                                                        );
                                                    }
                                                  },
                                                ),
                                                Container(
                                                  //width: width * 0.243,
                                                  child: Text(
                                                    recordList[index]["name"],
                                                    style: TextStyle(
                                                        fontSize: width * 0.028,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                //onTap: () {},
                                              ]),
                                            ),
                                          ],
                                        )),

                                /*
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Column(
                                          children: [

                                            ValueListenableBuilder<ButtonState>(
                                              valueListenable: playButtonNotifier,
                                              builder: (_, value, __) {
                                                switch (value) {
                                                  case ButtonState.loading:
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      width: 32.0,
                                                      height: 32.0,
                                                      child:
                                                          const CircularProgressIndicator(),
                                                    );
                                                  case ButtonState.paused:
                                                    return IconButton(
                                                      icon: const Icon(
                                                          Icons.play_arrow),
                                                      iconSize: 32.0,
                                                      onPressed: () {
                                                        setupList();
                                                        player.play();
                                                      },
                                                    );
                                                  case ButtonState.playing:
                                                    return IconButton(
                                                      icon:
                                                          const Icon(Icons.pause),
                                                      iconSize: 32.0,
                                                      onPressed: () {
                                                        player.pause();
                                                      },
                                                    );
                                                }
                                              },
                                            ),
                                            SvgPicture.asset(
                                              'assets/icons/play_arrow-24px_3.svg',
                                              width: width * 0.087,
                                            ),
                                          ),
                                         
                                  
                                        ],
                                      ),

                                    ],
                                  ),
                                  */
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: width * 0.024),
                          child: Column(children: [
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
                                //height: height * 0.003,
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
                          ]),
                        )
                      ],
                    ),
                  )
                ])
              ]),
            )
          ]);
        },
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  } //bottom sheet
}
