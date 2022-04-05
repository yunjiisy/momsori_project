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
import 'package:vibration/vibration.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = Get.find<UserController>();
  var today = DateTime.now().toString().split(' ')[0].split('-');

  int i = 0;
  Widget a = abc(0);
  late Widget c;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/background/home_background.jpeg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 3.h,
            ),
            Container(
              height: 48.h,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 0.02 * width,
                  left: 0.05 * width,
                  right: 0.02 * width,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        today[0] + '.' + today[1] + '.' + today[2],
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14.h,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(MenuScreen());
                          },
                          child: SvgPicture.asset(
                            'assets/icons/my_menu.svg',
                            width: 35.w,
                            height: 35.h,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              height: 44.h,
              child: Center(
                child: Text(
                  '${user.babyNickname}',
                  style: TextStyle(
                    fontSize: 0.04 * height,
                    fontWeight: FontWeight.w900,
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
                    '${user.babyWeek()} 주차  |  ' +
                        '${user.babyBirth} 예정  |  ' +
                        'D-' +
                        '${user.babyDay()}',
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
            InkWell(
                onTap: () {
                  setState(() {
                    ++i;
                    if (i == 6) {
                      i = 0;
                    }
                    print(i);
                  });
                  Vibration.vibrate(duration: 100);
                },
                child: abc(i)),
            SizedBox(
              height: 7.h,
            ),
            InkWell(
              onTap: () {
                Get.to(
                  RecoderScreen(),
                  transition: Transition.downToUp,
                );
              },
              child: SvgPicture.asset(
                'assets/icons/녹음아이콘.svg',
                width: 80.w,
                height: 80.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget abc(int i) {
  return Column(children: [
    // Container(
    //   height: 77.h,
    //   width: 252.w,
    //   child: Center(
    //     child: Text(
    //       topic[i],
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         color: Color(0xFFD7C1B9),
    //         fontSize: 15.0,
    //         fontWeight: FontWeight.w700,
    //       ),
    //     ),
    //   ),
    //   decoration: BoxDecoration(
    //       color: Colors.transparent,
    //       image: DecorationImage(
    //           image: AssetImage('assets/background/hometalk.jpeg'),
    //           fit: BoxFit.cover,
    //           opacity: 1.8,
    //         )),),

    Container(
      child: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage(
                  'assets/background/hometalk.jpeg',
                ),
                width: 320,
                height: 92,
                fit: BoxFit.cover,
              )),
          Positioned(
            //top: 30.h,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 26.h),
                width: 240.h,
                child: Text(
                  topic[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFD7C1B9),
                    fontSize: 14.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),

    // child: CustomPaint(
    //   painter: BubblePainter2(),
    //   child: Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Center(
    //       child: Text(
    //         topic[i],
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //           color: Color(0xFFD7C1B9),
    //           fontSize: 15.0,
    //           fontWeight: FontWeight.w700,
    //         ),
    //       ),
    //     ),
    //   ),
    // ),

    SizedBox(
      height: 15.h,
    ),
    Container(
      padding: EdgeInsets.only(
        right: 0,
      ),
      child: Image.asset(
        "assets/icons/확인용.gif",
        height: 187.h,
        width: 189.w,
      ),
    ),
  ]);
}
