import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:momsori/widgets/taedam_story.dart';

class TaedamScreen extends StatefulWidget {
  @override
  _TaedamScreenState createState() => _TaedamScreenState();
}

class _TaedamScreenState extends State<TaedamScreen> {
  var _month = 5;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Text(
          '태담가이드',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
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
            inactiveTrackColor: Color(0xFFC4C4C4).withOpacity(0.3),
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
          height: 50.h,
        ),
        Expanded(
          child: DraggableScrollbar.arrows(
            controller: _scrollController,
            alwaysVisibleScrollThumb: true,
            backgroundColor: Color(0xFFC4C4C4),
            child: ListView.builder(
              padding: EdgeInsets.all(5),
              controller: _scrollController,
              itemCount: taedamStories[_month].length,
              // itemExtent: 250.0,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: taedamStories[_month][index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
