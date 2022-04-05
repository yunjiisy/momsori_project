import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:momsori/getx_controller/record_list_controller.dart';
import 'package:momsori/getx_controller/record_sound_controller.dart';
import 'package:momsori/utils/record_state.dart';
import 'package:momsori/widgets/contants.dart';
import 'package:momsori/widgets/record_buttons/pause_button.dart';
import 'package:momsori/widgets/record_buttons/playing_button.dart';
import 'package:momsori/widgets/record_buttons/prepare_play_button.dart';
import 'package:momsori/widgets/record_buttons/prepare_record_button.dart';
import 'package:momsori/widgets/record_buttons/recording_button.dart';
import 'package:path_provider/path_provider.dart';

class RecoderScreen extends StatefulWidget {
  @override
  _RecoderScreenState createState() => _RecoderScreenState();
}

class _RecoderScreenState extends State<RecoderScreen> {
  final rlController = Get.put<RecordListController>(RecordListController());
  final recordSoundController = Get.put<RecordSoundController>(
    RecordSoundController(),
    tag: 'recordSound',
  );

  callCategoryList() async {
    var tempDir = await getExternalStorageDirectory();
    var directoryEx =
        Directory('${tempDir!.parent.parent.parent.parent.path}/momsound/');
    List<FileSystemEntity> entries =
        directoryEx.listSync(recursive: false).toList();
    if(rlController.categories.isEmpty){
      rlController.categories.add('+ 카테고리 추가');
    }
    if (rlController.categories.first == '+ 카테고리 추가') {
      rlController.categories.removeLast();
      entries.forEach((element) {
        var tmpString = element.path
            .substring(element.parent.path.length + 1, element.path.length);
        rlController.categories.add(tmpString);
      });
      rlController.categories.add('+ 카테고리 추가');
    }
  }

  @override
  void initState() {
    super.initState();
    callCategoryList();
  }

  @override
  void dispose() {
    super.dispose();
    recordSoundController.resetRecordTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background/calendar_image.jpeg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {

                        Get.back();
                      },
                      child: Container(
                        height: 50,
                        width: 40,
                        child: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '녹음',
                    //style: kTitleStyle,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.h),
                  ),
                ],
              ),
              SizedBox(
                height: 64.h,
              ),
              Container(
                child: Image.asset('assets/icons/녹음화면캐릭터.gif'),
                height: 250.h,
                width: 250.w,
              ),
              SizedBox(
                height: 30.h,
              ),
              Expanded(
                child: Obx(
                  () {
                    if (recordSoundController.recordState.value ==
                        RecordState.prepareRecord) {
                      return PrepareRecordButton();
                    } else if (recordSoundController.recordState.value ==
                        RecordState.recording) {
                      return RecordingButton();
                    } else if (recordSoundController.recordState.value ==
                        RecordState.preparePlay) {
                      return PreparePlayingButton();
                    } else if (recordSoundController.recordState.value ==
                        RecordState.pause) {
                      return PauseButton();
                    } else {
                      return PlayingButton();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
