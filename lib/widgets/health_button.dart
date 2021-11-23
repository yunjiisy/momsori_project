import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthButton extends StatelessWidget {
  Map<DateTime, List> health;
  DateTime selectDay;
  String image;
  String healthtext;

  HealthButton(this.health, this.selectDay, this.image, this.healthtext);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          IconButton(
            constraints: BoxConstraints(),
            padding: EdgeInsets.only(top: 0),
            onPressed: () {
              health[selectDay] = [image];
              health[selectDay]!.add(healthtext);


              print(health[selectDay]);
              print(selectDay);
            },
            icon: SvgPicture.asset(image),
            highlightColor: Colors.black,
            focusNode: FocusNode(),
            iconSize: 26.h,
            
          ),
          Text(healthtext,
          style: TextStyle(fontSize:13.h),)
        ],
      ),
    );
  }
}
