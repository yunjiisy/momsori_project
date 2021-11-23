import 'package:flutter/material.dart';
import 'package:momsori/screens/diary_edit.dart';

class EmotionButton extends StatelessWidget {
  //EmotionButton(Map<DateTime, List> map, [DateTime dateTime]);

  Map<DateTime, List> events;
  DateTime selectDay;
  int color;
  Map<DateTime, List> feeling;
  String feelingText;

  EmotionButton(
      this.events, this.selectDay, this.color, this.feeling, this.feelingText);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    bool valDate = date.isBefore(selectDay);

    return Column(
      children: [
        IconButton(
          constraints: BoxConstraints(),
          padding: EdgeInsets.only(top: 0),
          onPressed: () {
            //change Icon color when pressed
            if (valDate) {

            } else {
              events[selectDay] = [color];
              feeling[selectDay] = [feelingText];
              print('하하하하');

              print(events[selectDay]);
              print(feeling[selectDay]);
            }
          },
          icon: Icon(
            Icons.circle,
            color: Color(color),
          ),
        ),
        Text(feelingText)
      ],
    );
  }
}
