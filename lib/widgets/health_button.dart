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
  bool _hasBeenPressed = false;

  @override
  Widget build(BuildContext context) {
    final diaryController = Get.put(DiaryController());

    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        children: [
          Transform.scale(
            scale: 2.0,
            child: IconButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.only(top: 0, left: 9.6.h, right: 9.6.h),
              onPressed: () {
                // widget.health[widget.selectDay] = [widget.image];
                // widget.health[widget.selectDay]!.add(widget.healthtext);
                setState(() {
                  if (diaryController.health[widget.selectDay] == null) {
                    diaryController.health[widget.selectDay] = [widget.image];

                    diaryController.health[widget.selectDay]!
                        .add(widget.healthtext);
                    _hasBeenPressed = !_hasBeenPressed;
                  } else {
                    if (diaryController.health[widget.selectDay]![0] ==
                        "assets/icons/No_image.svg") {
                      diaryController.health[widget.selectDay]![0] =
                          widget.image;
                      diaryController.health[widget.selectDay]![1] =
                          widget.healthtext;
                      _hasBeenPressed = !_hasBeenPressed;
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
                      _hasBeenPressed = !_hasBeenPressed;
                    }
                  }
                  if (diaryController.events[widget.selectDay] == null) {
                    diaryController.events[widget.selectDay] = [
                      'assets/icons/No_image.svg'
                    ];
                    diaryController.feeling[widget.selectDay] = [" "];
                  }
                  // _hasBeenPressed = !_hasBeenPressed;
                });

                print(diaryController.health[widget.selectDay]);
                print(widget.selectDay);
              },
              icon: _hasBeenPressed
                  ? SvgPicture.asset(widget.image.substring(0, 14) +
                      "건강" +
                      widget.image.substring(14))
                  : SvgPicture.asset(widget.image),
              // icon: _hasBeenPressed
              //     ? SvgPicture.asset('assets/icons/Frame 52.svg')
              //     : SvgPicture.asset(widget.image),
              highlightColor: Color.fromARGB(255, 226, 226, 226),
              focusNode: FocusNode(),

              //iconSize: 26.h,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            widget.healthtext,
            style: TextStyle(fontSize: 11.h, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
