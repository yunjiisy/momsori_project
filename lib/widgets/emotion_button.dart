import 'package:flutter/material.dart';
import 'package:momsori/screens/diary_edit.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new IconButton(
          constraints: BoxConstraints(),
          padding: EdgeInsets.only(top: 0),
          onPressed: () {
            //change Icon color when pressed
            widget.events[widget.selectDay] = [widget.color];
            widget.feeling[widget.selectDay] = [widget.feelingText];
            // print(events[selectDay]);
            // print(feeling[selectDay]);
            setState(() {
              _hasBeenPressed = !_hasBeenPressed;
            });
          },
          icon: Icon(
            Icons.circle,
            color: _hasBeenPressed ? Colors.black12 : Color(widget.color),
          ),
        ),
        Text(widget.feelingText)
      ],
    );
  }
}
