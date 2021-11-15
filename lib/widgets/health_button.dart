import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HealthButton extends StatelessWidget {
  Map<DateTime, List> health;
  DateTime selectDay;
  String image;
  String healthtext;

  HealthButton(this.health, this.selectDay, this.image, this.healthtext);
  @override
  Widget build(BuildContext context) {
    return IconButton(
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
      
    );
  }
}
