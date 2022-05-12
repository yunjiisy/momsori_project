// ignore_for_file: deprecated_member_use
import 'dart:io';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:momsori/getx_controller/record_list_controller.dart';
import 'package:momsori/my_keep_keyboard_popup_munu/src/keep_keyboard_popup_menu_item.dart';
import 'package:momsori/my_keep_keyboard_popup_munu/src/with_keep_keyboard_popup_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:momsori/screens/search_screen.dart';
import 'package:momsori/widgets/save_dialog/add_category.dart';
import 'package:momsori/widgets/notifiers/play_button_notifier.dart';
import 'package:momsori/widgets/notifiers/repeat_button_notifier.dart';

List<Map> fileDataList = [];

class ProgressBarState {
  final Duration current;
  final Duration buffered;
  final Duration total;

  ProgressBarState(
      {required this.buffered, required this.current, required this.total});

  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
}

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late ConcatenatingAudioSource _playlist =
      ConcatenatingAudioSource(children: []);
  bool _editMode = false;
  bool _clicked = false;
  final textController = TextEditingController();
  final rlController = Get.put<RecordListController>(RecordListController());
  final player = AudioPlayer();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final playButtonNotifier = PlayButtonNotifier();
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final progressNotifier = ValueNotifier<ProgressBarState>(ProgressBarState(
    current: Duration.zero,
    total: Duration.zero,
    buffered: Duration.zero,
  ));

  var _index = Get.arguments;

  onShuffleButtonPressed() async {
    final enable = !player.shuffleModeEnabled;
    if (enable) {
      await player.shuffle();
    }
    await player.setShuffleModeEnabled(enable);
  }

  onPreviousSongButtonPressed() {
    player.seekToPrevious();
  }

  onNextSongButtonPressed() {
    player.seekToNext();
  }

  onRepeatButtonPressed() {
    repeatButtonNotifier.nextState();
    switch (repeatButtonNotifier.value) {
      case RepeatState.off:
        player.setLoopMode(LoopMode.off);
        break;
      case RepeatState.repeatSong:
        player.setLoopMode(LoopMode.one);
        break;
      case RepeatState.repeatPlaylist:
        player.setLoopMode(LoopMode.all);
    }
  }

  renameFileDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SafeArea(
            child: AlertDialog(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("파일 이름"),
                  TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                new CupertinoButton(
                    child: Text(
                      "취소",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        textController.clear();
                      });
                      print('rename file cancel');
                      Navigator.pop(context);
                    }),
                new CupertinoButton(
                    child: Text(
                      "확인",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      renameFile("/" + textController.text + ".mp3");
                      textController.clear();
                      setState(() {});
                      print('rename file ok');
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }

  renameFile(String newFile) {
    setState(() {
      fileDataList.forEach((element) {
        if (element["checked"] == true) {
          File tmpFile = File(element["path"]);
          String tmpPath = element["parent"] + newFile;
          tmpFile.rename(tmpPath);
          String tmpName = newFile.substring(1, newFile.length - 4);
          element["name"] = tmpName;
          element["path"] = tmpFile.path;
          element["checked"] = false;
          element["uri"] = tmpFile.uri;
        }
      });
    });
  }

  deleteFile() {
    fileDataList.forEach((element) {
      setState(() {
        if (element["checked"] == true) {
          File tmpFile = File(element["path"]);
          tmpFile.delete();
          fileDataList.remove(element);
        }
      });
    });
  }

  deleteFileDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SafeArea(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
              contentPadding: EdgeInsets.fromLTRB(26, 26, 26, 26),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "해당 파일들을 삭제하시겠습니까?",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("해당 녹음들은 영구 삭제됩니다.", style: TextStyle(fontSize: 18)),
                ],
              ),
              actions: <Widget>[
                new CupertinoButton(
                    child: Text(
                      "취소",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      setState(() {});
                      print('delete file cancel');
                      Navigator.pop(context);
                    }),
                new CupertinoButton(
                    child: Text(
                      "확인",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      deleteFile();
                      setState(() {});
                      print('delete file ok');
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }

  callParentFileList(Directory parent) async {
    List<FileSystemEntity> entries = parent.listSync(recursive: false).toList();
    entries.whereType<File>().forEach((element) {
      var tmpString = element.path
          .substring(element.parent.path.length + 1, element.path.length);
      tmpString = tmpString.substring(0, tmpString.length - 4);
      File tmpFile = File(element.path);
      String date =
          DateFormat('yy년 MM월 dd일').format(tmpFile.statSync().modified);
      fileDataList.add({
        "name": tmpString,
        "path": element.path,
        "checked": false,
        "clicked": false,
        "date": date,
        "uri": element.uri,
        "parent": element.parent.path,
      });
    });
  }

  callFileList() async {
    if (_index == 0) {
      if (fileDataList.isEmpty) {
        callParentFileList(Directory(rlController.categoryData[0]["path"]));
        rlController.categoryData.forEach((element) {
          if (element["name"] != "모든 녹음") {
            var directoryEx = Directory(element["path"]);
            List<FileSystemEntity> entries =
                directoryEx.listSync(recursive: false).toList();
            entries.forEach((element) {
              var tmpString = element.path.substring(
                  element.parent.path.length + 1, element.path.length);
              tmpString = tmpString.substring(0, tmpString.length - 4);
              File tmpFile = File(element.path);
              String date =
                  DateFormat('yy년 MM월 dd일').format(tmpFile.statSync().modified);
              fileDataList.add({
                "name": tmpString,
                "path": element.path,
                "checked": false,
                "clicked": false,
                "date": date,
                "uri": element.uri,
                "parent": element.parent.path,
              });
            });
          }
        });
      }
    } else {
      if (fileDataList.isEmpty) {
        var directoryEx = Directory(rlController.categoryData[_index]["path"]);
        List<FileSystemEntity> entries =
            directoryEx.listSync(recursive: false).toList();
        entries.forEach((element) {
          var tmpString = element.path
              .substring(element.parent.path.length + 1, element.path.length);
          File tmpFile = File(element.path);
          String date =
              DateFormat('yy년 MM월 dd일').format(tmpFile.statSync().modified);
          fileDataList.add({
            "name": tmpString,
            "path": element.path,
            "checked": false,
            "selected": false,
            "date": date,
            "uri": element.uri,
            "parent": element.parent.path,
          });
        });
      }
    }
  }

  moveFile(String newCategory) {
    setState(() {
      fileDataList.forEach((element) {
        if (element["checked"] == true) {
          File tmpFile = File(element["path"]);
          String tmpName = element["name"] + '.mp3';
          tmpFile.rename(
              '/storage/emulated/0/momsound/' + newCategory + '/' + tmpName);
          element["path"] = tmpFile.path;
          element["uri"] = tmpFile.uri;
        }
      });
    });
  }

  moveFileDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SafeArea(
            child: AlertDialog(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("카테고리 이동"),
                  GetBuilder<RecordListController>(
                    init: rlController,
                    builder: (_) => WithKeepKeyboardPopupMenu(
                      childBuilder: (context, openPopup) => InkWell(
                        onTap: openPopup,
                        child: Text(
                          '${rlController.category}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      backgroundBuilder: (context, child) => Material(
                        elevation: 20,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        shadowColor: Colors.grey,
                        child: child,
                      ),
                      menuBuilder: (context, closePopup) => Container(
                        padding:
                            EdgeInsets.only(bottom: 10, left: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        height: 170.h,
                        width: 120.w,
                        child: ListView.builder(
                          itemCount: _.categories.length,
                          itemBuilder: (context, index) {
                            return KeepKeyboardPopupMenuItem(
                              height: 30.h,
                              child: index == _.categories.length - 1
                                  ? InkWell(
                                      onTap: () {
                                        closePopup();
                                        Get.dialog(
                                          addCategory(context),
                                        );
                                      },
                                      child: Center(
                                        child: Text(
                                          '${_.categories[index]}',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        rlController.changeIndex(index);
                                        rlController.changeCategory(
                                            rlController.categories[index]);
                                        closePopup();
                                      },
                                      child: Container(
                                        height: 30.h,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            rlController.categoryIndex == index
                                                ? SvgPicture.asset(
                                                    'assets/icons/체크박스선택.svg')
                                                : SvgPicture.asset(
                                                    'assets/icons/체크박스선택x.svg'),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            Text(
                                              '${_.categories[index]}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                new CupertinoButton(
                    child: Text(
                      "취소",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        textController.clear();
                      });
                      print('Rename Directory Cancel');
                      Navigator.pop(context);
                    }),
                new CupertinoButton(
                    child: Text(
                      "확인",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      moveFile(rlController.category);
                      textController.clear();
                      setState(() {});
                      print('OK');
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }

  //AudioPlayer? _player;
  setupFile(String filePath, String tag) async {
    _playlist.add(ConcatenatingAudioSource(
        children: [AudioSource.uri(Uri.file(filePath), tag: tag)]));
    await player.setAudioSource(_playlist);
  }

  // Future<void> setupFile(String filePath, String tag, AudioPlayer player) async {
  //   _playlist.add(ConcatenatingAudioSource(
  //       children: [AudioSource.uri(Uri.file(filePath), tag: tag)]));
  //   await player.setAudioSource(_playlist);
  // }

  setupAllFile() async {
    fileDataList.forEach((element) {
      _playlist.add(ConcatenatingAudioSource(children: [
        AudioSource.uri(Uri.file(element["path"]), tag: element["name"]),
      ]));
    });
    await player.setAudioSource(_playlist);
  }

  setupList() async {
    fileDataList.forEach((element) {
      if (element["checked"]) {
        _playlist.add(ConcatenatingAudioSource(children: [
          AudioSource.uri(Uri.file(element["path"]), tag: element["name"]),
        ]));
      }
    });
    await player.setAudioSource(_playlist);
  }

  _init() async {
    _listenForChangesInPlayerState();
    _listenForChangesInSequenceState();
    _listenForChangesInPlayerPosition();
    _listenForChangesInBufferedPosition();
    _listenForChangesInTotalDuration();
  }

  _listenForChangesInPlayerState() {
    player.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        player.seek(Duration.zero);
        player.pause();
      }
    });
  }

  _listenForChangesInPlayerPosition() {
    player.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  _listenForChangesInBufferedPosition() {
    player.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
  }

  _listenForChangesInTotalDuration() {
    player.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  _listenForChangesInSequenceState() {
    player.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;

      // update current song title
      final currentItem = sequenceState.currentSource;
      final title = currentItem?.tag as String?;
      currentSongTitleNotifier.value = title ?? '';

      // update playlist
      final playlist = sequenceState.effectiveSequence;
      final titles = playlist.map((item) => item.tag as String).toList();
      playlistNotifier.value = titles;

      // update shuffle mode
      isShuffleModeEnabledNotifier.value = sequenceState.shuffleModeEnabled;

      // update previous and next buttons
      if (playlist.isEmpty || currentItem == null) {
        isFirstSongNotifier.value = true;
        isLastSongNotifier.value = true;
      } else {
        isFirstSongNotifier.value = playlist.first == currentItem;
        isLastSongNotifier.value = playlist.last == currentItem;
      }
    });
  }

  seek(Duration position) {
    player.seek(position);
  }

  clearMode() {
    _editMode = false;
    _clicked = false;
    fileDataList.clear();
    player.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (fileDataList.isEmpty) callFileList();
    _init();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background/storage_background.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            clearMode();
                            Get.back(closeOverlays: true);
                            setState(() {});
                          },
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                        TextButton(
                          onPressed: () {
                            print(fileDataList);
                            setState(() {});
                          },
                          child: Text(
                            rlController.categoryData[_index]["name"],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            print('search');
                            _clicked = false;
                            setState(() {});
                            Get.to(() => SearchScreen(),
                                transition: Transition.downToUp);
                          },
                          child: Text(
                            '검색',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            print('edit mode');
                            // ignore: unnecessary_statements
                            _clicked = false;
                            _editMode = !_editMode;
                            rlController.categoryData.forEach((element) {
                              element["checked"] = false;
                              element["clicked"] = false;
                            });
                            setState(() {});
                          },
                          child: Text(
                            _editMode ? '확인' : '편집',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: width * 0.006, top: height * 0.01),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Image.asset('assets/icons/storage_icon1.png')],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: _editMode,
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                fileDataList.forEach((element) {
                                  element["checked"] = true;
                                });
                                setState(() {});
                              },
                              icon: Icon(Icons.check)),
                          Text(
                            "전체 선택",
                            style: TextStyle(
                              wordSpacing: 0.7,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            _editMode = false;
                            _clicked = true;
                            setState(() {});
                            setupAllFile();
                          },
                          icon: Icon(Icons.play_arrow),
                          // iconSize: width * 0.05,
                        ),
                        Text(
                          "전체 재생",
                          style: TextStyle(
                            wordSpacing: 0.7,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                fileDataList.isEmpty
                    ? Container(
                        margin: EdgeInsets.fromLTRB(14, 100, 0, 0),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '폴더가 비어있어요.',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 122, 112, 112)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '엄마,아빠의 목소리를 녹음해 주세요!',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 122, 112, 112)),
                            ),
                          ],
                        ))
                    : Expanded(
                        child: _editMode == false
                            ? Container(
                                child: ListView.builder(
                                itemCount: fileDataList.length,
                                itemBuilder: (context, index) {
                                  print(fileDataList.length);
                                  if (fileDataList[index]["clicked"] == null) {
                                    fileDataList[index]["clicked"] = false;
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: ListTile(
                                      leading: fileDataList[index]["clicked"]
                                          ? SvgPicture.asset(
                                              'assets/background/storage_pause.svg')
                                          : SvgPicture.asset(
                                              'assets/background/storage_play.svg'),
                                      title: Text(
                                        fileDataList[index]["name"],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                      subtitle: Text(
                                        fileDataList[index]["date"].toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      onTap: () {
                                        for (int i = 0;
                                            i < fileDataList.length;
                                            i++) {
                                          if (i != index) {
                                            fileDataList[i]["clicked"] = false;
                                            _clicked = false;
                                          }
                                        }
                                        if (!_clicked) {
                                          _clicked = true;
                                          fileDataList[index]["clicked"] = true;
                                        } else {
                                          _clicked = false;
                                          fileDataList[index]["clicked"] =
                                              false;
                                        }

                                        _playlist.clear();
                                        //setState(() {});
                                        player.pause();
                                        setupFile(fileDataList[index]["path"],
                                            fileDataList[index]["name"]);
                                        setState(() {});
                                      },
                                    ),
                                  );
                                },
                              ))
                            : Container(
                                child: ListView.builder(
                                itemCount: fileDataList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: Text(
                                          fileDataList[index]["name"],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                        subtitle: Text(
                                          fileDataList[index]["date"],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        value: fileDataList[index]["checked"],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            fileDataList[index]["checked"] =
                                                !fileDataList[index]["checked"];
                                          });
                                        }),
                                  );
                                },
                              )),
                      ),
                !_editMode
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Visibility(
                          visible: _clicked,
                          child: Column(
                            children: [
                              ValueListenableBuilder<String>(
                                valueListenable: currentSongTitleNotifier,
                                builder: (_, title, __) {
                                  return Text(title,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 46, 46, 46),
                                          fontWeight: FontWeight.w700));
                                },
                              ),
                              SizedBox(height: height * 0.005),
                              ValueListenableBuilder<ProgressBarState>(
                                valueListenable: progressNotifier,
                                builder: (_, value, __) {
                                  return ProgressBar(
                                    barHeight: 0.006 * height,
                                    thumbRadius: 0.01 * height,
                                    progressBarColor: Color(0XFFFFA9A9),
                                    thumbColor:
                                        Color.fromARGB(255, 255, 154, 154),
                                    thumbGlowColor: Color(0XFFFFA9A9),
                                    bufferedBarColor:
                                        Color.fromARGB(255, 255, 222, 222),
                                    onSeek: seek,
                                    progress: value.current,
                                    buffered: value.buffered,
                                    total: value.total,
                                    timeLabelPadding: 2,
                                    timeLabelTextStyle: TextStyle(
                                        fontSize: height * 0.016,
                                        color: Colors.black),
                                  );
                                },
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ValueListenableBuilder<RepeatState>(
                                    valueListenable: repeatButtonNotifier,
                                    builder: (context, value, child) {
                                      Icon icon;

                                      switch (value) {
                                        case RepeatState.off:
                                          icon = Icon(
                                            Icons.repeat,
                                            color: Colors.grey,
                                          );
                                          break;
                                        case RepeatState.repeatSong:
                                          icon = Icon(Icons.repeat_one);
                                          break;
                                        case RepeatState.repeatPlaylist:
                                          icon = Icon(Icons.repeat);
                                          break;
                                      }
                                      return IconButton(
                                        icon: icon,
                                        onPressed: onRepeatButtonPressed,
                                      );
                                    },
                                  ),
                                  ValueListenableBuilder<bool>(
                                    valueListenable: isFirstSongNotifier,
                                    builder: (_, isFirst, __) {
                                      return IconButton(
                                        icon: Icon(Icons.skip_previous),
                                        onPressed: (isFirst)
                                            ? null
                                            : onPreviousSongButtonPressed,
                                      );
                                    },
                                  ),
                                  ValueListenableBuilder<ButtonState>(
                                    valueListenable: playButtonNotifier,
                                    builder: (_, value, __) {
                                      switch (value) {
                                        case ButtonState.loading:
                                          return Container(
                                            margin: const EdgeInsets.all(8.0),
                                            width: 32.0,
                                            height: 32.0,
                                            child:
                                                const CircularProgressIndicator(),
                                          );
                                        case ButtonState.paused:
                                          return IconButton(
                                            icon: const Icon(Icons.play_arrow),
                                            iconSize: 32.0,
                                            onPressed: () {
                                              player.play();
                                            },
                                          );
                                        case ButtonState.playing:
                                          return IconButton(
                                            icon: const Icon(Icons.pause),
                                            iconSize: 32.0,
                                            onPressed: () {
                                              player.pause();
                                            },
                                          );
                                      }
                                    },
                                  ),
                                  ValueListenableBuilder<bool>(
                                    valueListenable: isLastSongNotifier,
                                    builder: (_, isLast, __) {
                                      return IconButton(
                                        icon: Icon(Icons.skip_next),
                                        onPressed: (isLast)
                                            ? null
                                            : onNextSongButtonPressed,
                                      );
                                    },
                                  ),
                                  ValueListenableBuilder<bool>(
                                    valueListenable:
                                        isShuffleModeEnabledNotifier,
                                    builder: (context, isEnabled, child) {
                                      return IconButton(
                                        icon: (isEnabled)
                                            ? Icon(Icons.shuffle)
                                            : Icon(Icons.shuffle,
                                                color: Colors.grey),
                                        onPressed: onShuffleButtonPressed,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Visibility(
                            visible: _editMode,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        print("move to others");
                                        moveFileDialog();
                                      },
                                      icon: Icon(Icons.arrow_right_alt),
                                      iconSize: 23,
                                    ),
                                    Text(
                                      "이동",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  '|',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffdadada),
                                    fontSize: 23,
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        print("delete");
                                        deleteFileDialog();
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                      ),
                                      iconSize: 23,
                                    ),
                                    Text(
                                      "삭제",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  '|',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffdadada),
                                    fontSize: 23,
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        renameFileDialog();
                                        print("rename");
                                      },
                                      icon: Icon(Icons.edit),
                                      iconSize: 23,
                                    ),
                                    Text(
                                      "이름 변경",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                                // Column(
                                //   children: [
                                //     IconButton(
                                //       onPressed: () {
                                //         _clicked = true;
                                //         _editMode = false;
                                //         setState(() {});
                                //         setupList();
                                //       },
                                //       icon: Icon(Icons.play_arrow),
                                //       iconSize: 30,
                                //     ),
                                //     Text(
                                //       "재생",
                                //       style: TextStyle(
                                //         fontSize: 16,
                                //         fontWeight: FontWeight.w500,
                                //         color: Colors.black,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            )),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
