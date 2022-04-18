import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:momsori/getx_controller/diary_controller.dart';
import 'package:get/get.dart';

class EmotionButton extends StatefulWidget {
  //EmotionButton(Map<DateTime, List> map, [DateTime dateTime]);

  Map<DateTime, List> events;
  DateTime selectDay;
  String color;
  Map<DateTime, List> feeling;
  String feelingText;

  EmotionButton(
      this.events, this.selectDay, this.color, this.feeling, this.feelingText);

  @override
  State<EmotionButton> createState() => _EmotionButtonState();
}

class _EmotionButtonState extends State<EmotionButton> {
  bool _hasBeenPressed(
      DateTime selectedDay, Map<DateTime, List> events, String color) {
    if (events[selectedDay] == null) {
      return false;
    } else if (events[selectedDay]!.contains(color)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final diaryController = Get.put(DiaryController());
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        children: [
          Transform.scale(
            scale: 2.7,
            child: IconButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.only(
                  top: 0, left: height * 0.009, right: height * 0.009),
              //iconSize: 30.h,
              onPressed: () {
                //change Icon color when pressed
                // diaryController.events[widget.selectDay] = [widget.color];
                // print(diaryController.events[widget.selectDay]);
                // diaryController.feeling[widget.selectDay] = [
                //   widget.feelingText
                // ];

                //print(events[selectDay]);
                //print(feeling[selectDay]);
                setState(() {
                  // _hasBeenPressed = pressed(
                  //     diaryController.events, widget.selectDay, widget.color);
                  if (diaryController.events[widget.selectDay] == null ||
                      diaryController.events[widget.selectDay]!.isEmpty ==
                          true) {
                    print(diaryController.events[widget.selectDay]);
                    diaryController.events[widget.selectDay] = [widget.color];

                    diaryController.feeling[widget.selectDay] = [
                      widget.feelingText
                    ];
                  } else {
                    if (diaryController.events[widget.selectDay]![0] ==
                        "assets/icons/No_image.svg") {
                      diaryController.events[widget.selectDay]![0] =
                          widget.color;
                      diaryController.feeling[widget.selectDay]![0] =
                          widget.feelingText;
                    } else {
                      diaryController.events[widget.selectDay]!
                              .contains(widget.color)
                          ? diaryController.events[widget.selectDay]!
                              .remove(widget.color)
                          : diaryController.events[widget.selectDay]!
                              .add(widget.color);

                      diaryController.feeling[widget.selectDay]!
                              .contains(widget.feelingText)
                          ? diaryController.feeling[widget.selectDay]!
                              .remove(widget.feelingText)
                          : diaryController.feeling[widget.selectDay]!
                              .add(widget.feelingText);
                    }
                  }
                  if (diaryController.health[widget.selectDay] == null) {
                    diaryController.health[widget.selectDay] = [
                      'assets/icons/No_image.svg',
                      " "
                    ];
                  }
                });
              },

              icon: _hasBeenPressed(
                      widget.selectDay, diaryController.events, widget.color)
                  ? SvgPicture.asset(widget.color.substring(0, 14) +
                      "_" +
                      widget.color.substring(14))
                  : SvgPicture.asset((widget.color)),
              // Icons.circle,
              // color: _hasBeenPressed ? Colors.black12 : Color(widget.color),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            widget.feelingText,
            style: TextStyle(fontSize: 11.3.h, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
