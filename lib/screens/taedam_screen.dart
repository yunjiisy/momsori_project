import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:momsori/widgets/taedam_story.dart';
import 'package:get/get.dart';

import '../widgets/contants.dart';

class TaedamScreen extends StatefulWidget {
  @override
  _TaedamScreenState createState() => _TaedamScreenState();
}

class _TaedamScreenState extends State<TaedamScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  var _month = 5;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background/calendar_image.jpeg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 13.h,
                ),
                Text(
                  '태담 가이드',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.w900),
                  // style: kTitleStyle,
                ),
              ],
            ),
            SizedBox(
              height: 46.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(10, (index) {
                  if (_month == index) {
                    return Container(
                      width: width * 0.09,
                      child: Center(
                        child: Text(
                          "${index + 1}개월",
                          style: TextStyle(
                            color: Color(0xFFFFA9A9),
                            fontWeight: FontWeight.w900,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                    );
                  } else
                    return Container(
                      width: width * 0.09,
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    );
                }),
              ),
            ),
            SliderTheme(
              data: SliderThemeData(
                inactiveTrackColor:
                    Color.fromARGB(255, 224, 224, 224).withOpacity(0.3),
                activeTrackColor: Color(0xFFC4C4C4).withOpacity(0.3),
                trackHeight: 3,
                thumbColor: Color(0xFFFFA9A9),
                overlayColor: Color(0xFFFFA9A9).withOpacity(0.5),
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 9),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 13.0),
                activeTickMarkColor: Color(0xFFC4C4C4),
                inactiveTickMarkColor: Color(0xFFC4C4C4),
                disabledActiveTickMarkColor: Color(0xFFC4C4C4),
                tickMarkShape: RoundSliderTickMarkShape(
                  tickMarkRadius: 6,
                ),
              ),
              child: Slider(
                value: _month.toDouble(),
                min: 0,
                max: 9,
                // label: '라벨',
                divisions: 9,
                onChanged: (double newValue) {
                  setState(() {
                    _month = newValue.round();
                  });
                },
              ),
            ),
            SizedBox(
              height: 28.h,
            ),
            Expanded(
              child: DraggableScrollbar.arrows(
                controller: _scrollController,
                alwaysVisibleScrollThumb: true,
                backgroundColor: Color(0xFFC4C4C4),
                child: ListView.builder(
                  padding: EdgeInsets.all(4),
                  controller: _scrollController,
                  itemCount: taedamStories[_month].length,
                  // itemExtent: 250.0,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(4.0),
                      child: taedamStories[_month][index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
