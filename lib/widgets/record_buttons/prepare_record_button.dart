import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:momsori/getx_controller/record_sound_controller.dart';

class PrepareRecordButton extends StatelessWidget {
  final recordSoundController =
      Get.find<RecordSoundController>(tag: 'recordSound');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '아이에게 목소리를 들려주세요🎧',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
        InkWell(
          onTap: recordSoundController.record,
          child: SvgPicture.asset(
            'assets/icons/record_icon.svg',
            height: 52.h,
            width: 52.h,
          ),
        ),
      ],
    );
  }
}
