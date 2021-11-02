import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:momsori/getx_controller/record_sound_controller.dart';
import 'package:momsori/widgets/record_buttons/save_button.dart';

class PlayingButton extends StatelessWidget {
  final recordSoundController =
      Get.find<RecordSoundController>(tag: 'recordSound');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
                'assets/icons/pause-black-18dp 2.svg',
                height: 25.h,
              ),
              onTap: recordSoundController.pausePlayer,
            ),
            SvgPicture.asset(
              'assets/icons/record_icon-1.svg',
              height: 72.h,
            ),
            SaveButton(),
          ],
        ),
      ],
    );
  }
}
