import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:momsori/getx_controller/record_sound_controller.dart';
import 'package:momsori/widgets/record_buttons/save_button.dart';

class RecordingButton extends StatelessWidget {
  final recordSoundController =
      Get.find<RecordSoundController>(tag: 'recordSound');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '엄마의 목소리를 듣고 있어요🎵',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Obx(() => Text(
              recordSoundController.recordTime.value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            )),
        SizedBox(
          height: 63.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child: SvgPicture.asset(
                'assets/icons/play_arrow-24px.svg',
                height: 25.h,
              ),
            ),
            InkWell(
              child: SvgPicture.asset(
                'assets/icons/pause_ic.svg',
                height: 52.h,
              ),
              onTap: recordSoundController.stopRecorder,
            ),
            SaveButton(),
          ],
        ),
      ],
    );
  }
}
