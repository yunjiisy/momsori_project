import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:momsori/getx_controller/diary_controller.dart';
import 'package:get/get.dart';

class EmotionButton extends StatefulWidget {
  //EmotionButton(Map<DateTime, List> map, [DateTime dateTime]);

  Map<DateTime, List> events;
  DateTime selectDay;
  int color;
  Map<DateTime, List> feeling;
  String feelingText;

  EmotionButton(
      this.events, this.selectDay, this.color, this.feeling, this.feelingText);

  @override
  State<EmotionButton> createState() => _EmotionButtonState();
}

class _EmotionButtonState extends State<EmotionButton> {
  bool _hasBeenPressed = false;
  bool pressed(Map<DateTime, List> event, DateTime selectedDay, int color) {
    //if (diaryController.health[widget.selectDay] == null)
    if (event[selectedDay] == color) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final diaryController = Get.put(DiaryController());
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          new IconButton(
            constraints: BoxConstraints(),
            padding: EdgeInsets.only(top: 0, left: 6.h, right: 6.h),
            iconSize: 48.h,
            onPressed: () {
              //change Icon color when pressed
              diaryController.events[widget.selectDay] = [widget.color];
              diaryController.feeling[widget.selectDay] = [widget.feelingText];

              //print(events[selectDay]);
              //print(feeling[selectDay]);
              setState(() {
                _hasBeenPressed = pressed(
                    diaryController.events, widget.selectDay, widget.color);
              });
            },
            icon: Icon(
              Icons.circle,
              color: _hasBeenPressed ? Colors.black12 : Color(widget.color),
            ),
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
