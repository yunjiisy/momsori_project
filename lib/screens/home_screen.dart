import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:momsori/getx_controller/user_controller.dart';
import 'package:momsori/screens/menu_screen.dart';
import 'package:momsori/screens/recoder_screen.dart';
import 'package:momsori/widgets/custom_bubble/bubble_painter2.dart';
import 'package:momsori/widgets/topics.dart';

class HomeScreen extends StatelessWidget {
  final user = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 24.h,
        ),
        Container(
          height: 48.h,
          child: Padding(
            padding: EdgeInsets.only(
              left: 0.05 * width,
              right: 0.05 * width,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${user.babyWeek()}주차',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 0.06 * width,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(MenuScreen());
                  },
                  child: SvgPicture.asset(
                    'assets/icons/세팅선택x.svg',
                    width: 19.45.w,
                    height: 20.h,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Container(
          height: 44.h,
          child: Center(
            child: Text(
              '${user.userName}',
              style: TextStyle(
                fontSize: 0.04 * height,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Container(
          height: 16.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${user.babyBirth} 예정',
                style: TextStyle(
                  fontSize: 0.02 * height,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 0.025 * width,
              ),
              Text(
                '|',
                style: TextStyle(
                  fontSize: 0.02 * height,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 0.025 * width,
              ),
              Text(
                'D-${user.babyDay()}',
                style: TextStyle(
                  fontSize: 0.02 * height,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 36.h,
        ),
        Container(
          height: 64.h,
          width: 252.w,
          child: CustomPaint(
            painter: BubblePainter2(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  topic[0],
                  style: TextStyle(
                    color: Color(0xFFD7C1B9),
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 28.h,
        ),
        Container(
          padding: EdgeInsets.only(
            right: 10,
          ),
          child: Image.asset(
            "assets/images/gif_check.gif",
            height: 171.h,
            width: 185.w,
          ),
        ),
        SizedBox(
          height: 36.h,
        ),
        InkWell(
          onTap: () {
            Get.to(
              RecoderScreen(),
              transition: Transition.downToUp,
            );
          },
          child: SvgPicture.asset(
            'assets/icons/record_ic.svg',
            width: 56.w,
            height: 56.h,
          ),
        ),
      ],
    );
  }
}
