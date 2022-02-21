import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:momsori/getx_controller/diary_controller.dart';
import 'package:get/get.dart';

class HealthButton extends StatefulWidget {
  Map<DateTime, List> health;
  DateTime selectDay;
  String image;
  String healthtext;

  HealthButton(this.health, this.selectDay, this.image, this.healthtext);

  @override
  State<HealthButton> createState() => _HealthButtonState();
}

class _HealthButtonState extends State<HealthButton> {
  @override
  Widget build(BuildContext context) {
    final diaryController = Get.put(DiaryController());

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          IconButton(
            constraints: BoxConstraints(),
            padding: EdgeInsets.only(top: 0),
            onPressed: () {
              // widget.health[widget.selectDay] = [widget.image];
              // widget.health[widget.selectDay]!.add(widget.healthtext);
              setState(() {
                if (diaryController.health[widget.selectDay] == null) {
                  diaryController.health[widget.selectDay] = [widget.image];

                  diaryController.health[widget.selectDay]!
                      .add(widget.healthtext);
                } else {
                  diaryController.health[widget.selectDay]!
                          .contains(widget.image)
                      ? diaryController.health[widget.selectDay]!
                          .remove(widget.image)
                      : diaryController.health[widget.selectDay]!
                          .add(widget.image);

                  diaryController.health[widget.selectDay]!
                          .contains(widget.healthtext)
                      ? diaryController.health[widget.selectDay]!
                          .remove(widget.healthtext)
                      : diaryController.health[widget.selectDay]!
                          .add(widget.healthtext);
                }
                // _hasBeenPressed = !_hasBeenPressed;
              });

              print(diaryController.health[widget.selectDay]);
              print(widget.selectDay);
            },
            icon: SvgPicture.asset(widget.image),
            highlightColor: Colors.black,
            focusNode: FocusNode(),
            iconSize: 26.h,
          ),
          Text(
            widget.healthtext,
            style: TextStyle(fontSize: 13.h),
          )
        ],
      ),
    );
  }
}
