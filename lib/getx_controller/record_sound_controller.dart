import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:momsori/utils/record_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordSoundController extends GetxController {
  File? file;
  final Codec _codec = Codec.aacMP4;

  Rx<FlutterSoundPlayer> _mPlayer = FlutterSoundPlayer().obs;
  Rx<FlutterSoundRecorder> _mRecorder = FlutterSoundRecorder().obs;

  Rx<RecordState> recordState = RecordState.prepareRecord.obs;

  RxBool _mPlayerIsInited = false.obs;
  RxBool _mRecorderIsInited = false.obs;
  RxBool _mPlaybackReady = false.obs;
  RxString _mPath = 'momsound.m4a'.obs;

  RxString recordTime = '00:00'.obs;

  @override
  void onInit() {
    _mPlayer.value.openAudioSession().then((_) {
      _mPlayerIsInited.value = true;
    });

    openTheRecorder().then((_) {
      _mRecorderIsInited.value = true;
    });
    super.onInit();
  }

  @override
  void dispose() {
    _mPlayer.value.closeAudioSession();
    _mRecorder.value.closeAudioSession();
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    var recordState = await Permission.microphone.request();
    var storageState = await Permission.storage.request();

    if (recordState != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    if (storageState != PermissionStatus.granted) {
      print('저장 권한 에러');
    }

    await _mRecorder.value.openAudioSession();
    _mRecorderIsInited.value = true;
  }

  void record() async {
    _mRecorder.value
        .startRecorder(
      codec: _codec,
      toFile: _mPath.value,
    )
        .then((value) {
      recordState.value = RecordState.recording;
    });

    _mRecorder.value.setSubscriptionDuration(Duration(seconds: 1));

    _mRecorder.value.onProgress!.listen((e) {
      recordTime.value = recordTimeValue(e.duration);
    });
  }

  void stopRecorder() async {
    await _mRecorder.value.stopRecorder().then((_) {
      _mPlaybackReady.value = true;
      recordState.value = RecordState.preparePlay;
    });
  }

  void play() async {
    assert(_mPlayerIsInited.value &&
        _mPlaybackReady.value &&
        _mRecorder.value.isStopped &&
        _mPlayer.value.isStopped);

    _mPlayer.value
        .startPlayer(
            fromURI: _mPath.value,
            codec: _codec,
            whenFinished: () {
              recordState.value = RecordState.preparePlay;
            })
        .then((_) {
      recordState.value = RecordState.playing;
    });

    _mPlayer.value.setSubscriptionDuration(Duration(seconds: 1));

    _mPlayer.value.onProgress!.listen((e) {
      recordTime.value = recordTimeValue(e.position);
      print(e.position);
      print(e.duration);
    });
  }

  void pausePlayer() {
    _mPlayer.value.pausePlayer().then((_) {
      recordState.value = RecordState.pause;
    });
  }

  void resumePlayer() {
    _mPlayer.value.resumePlayer().then((_) {
      recordState.value = RecordState.playing;
    });
  }

  void stopPlayer() {
    _mPlayer.value.stopPlayer().then((_) {
      recordState.value = RecordState.preparePlay;
    });
  }

  void saveFile(String fileName, String category) async {
    String inputFile = '/data/user/0/com.example.momsori/cache/${_mPath.value}';
    var tempDir = await getExternalStorageDirectory();
    var directory = category != '전체 ▼'
        ? Directory('${tempDir!.path}/$category')
        : Directory(tempDir!.path);
    directory.create(recursive: true);
    print("디렉토리 경로");
    print(directory.path);
    String outputFile = '${directory.path}/$fileName.mp3';

    await flutterSoundHelper.convertFile(
        inputFile, Codec.aacMP4, outputFile, Codec.aacADTS);

    resetRecordTime();
  }

  String recordTimeValue(Duration recordTime) {
    var time = recordTime.inSeconds;
    if (time < 10) {
      return '00:0$time';
    } else if (time < 60) {
      return '00:$time';
    } else if (time < 600) {
      var min = time ~/ 60 + 1;
      var sec = time - min * 60;
      if (sec < 10) {
        return '0$min:0$sec';
      } else {
        return '0$min:$sec';
      }
    } else {
      var min = time ~/ 60 + 1;
      var sec = time - min * 60;
      if (sec < 10) {
        return '$min:0$sec';
      } else {
        return '$min:$sec';
      }
    }
  }

  void resetRecordTime() {
    recordTime.value = '00:00';
  }

  bool get isPlayerPaused => _mPlayer.value.isPaused;

  bool get isRecordPaused => _mRecorder.value.isPaused;

  bool get isRecordStopped => _mRecorder.value.isStopped;

  bool get isPlayerStopped => _mPlayer.value.isStopped;
}
