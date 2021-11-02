import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:momsori/getx_controller/record_sound_controller.dart';
import 'package:momsori/widgets/save_dialog/save_dialog.dart';

class SaveButton extends StatelessWidget {
  final recordSoundController =
      Get.find<RecordSoundController>(tag: 'recordSound');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SvgPicture.asset(
        'assets/icons/stop-black-18dp_2.svg',
        height: 30.h,
      ),
      onTap: () {
        if (!recordSoundController.isPlayerStopped) {
          recordSoundController.stopPlayer();
        }
        if (!recordSoundController.isRecordPaused) {
          recordSoundController.stopRecorder();
        }
        Get.dialog(
          saveDialog(context),
        );
      },
    );
  }
}
