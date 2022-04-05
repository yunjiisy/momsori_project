import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:momsori/screens/category_screen.dart';
import 'package:momsori/widgets/notifiers/play_button_notifier.dart';
import 'package:momsori/widgets/notifiers/repeat_button_notifier.dart';

class ProgressBarState {
  final Duration current;
  final Duration buffered;
  final Duration total;

  ProgressBarState(
      {required this.buffered, required this.current, required this.total});

  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
}
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
  final TextEditingController textController = TextEditingController();
  final cs = CategoryScreen();
  bool _clicked = false;
  final player = AudioPlayer();
  _init() async {
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
      } else { // completed
        player.seek(Duration.zero);
        player.pause();
      }
    });
    player.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else {
        playButtonNotifier.value = ButtonState.playing;
      }
    });
    player.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
    player.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
    player.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }
  setupFile(String filePath) async {
    if (_clicked) {
      player.setFilePath(filePath);
    } else {
      player.stop();
    }
  }
  seek(Duration position) {
    player.seek(position);
  }
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
  filterSearchResults(String query) {
    searchDataList.clear();
    tmpDataList.addAll(fileDataList);
    tmpDataList.forEach((element) {
      String fileName = element["name"];
      if (fileName.contains(query)) {
        searchDataList.add(element);
      }
    });
    tmpDataList.clear();
    setState(() {});
  }
  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: textController,
              decoration: InputDecoration(
                labelText: "검색",
                hintText: "검색",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
            IconButton(
                onPressed: () {
                  searchDataList.clear();
                  textController.clear();
                  Get.back(closeOverlays: true);
                  setState(() {});
                },
                icon: Icon(Icons.arrow_back)),
            searchDataList.isEmpty
                ? Expanded(
                    child: Container(),
                  )
                : Expanded(
                    child: Container(
                        child: ListView.builder(
                      itemCount: searchDataList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: ListTile(
                            title: Text(
                              searchDataList[index]["name"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            trailing: Text(
                              searchDataList[index]["date"].toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {
                              if (!_clicked) _clicked = true;
                              player.pause();
                              setupFile(searchDataList[index]["path"]);
                              setState(() {});
                            },
                          ),
                        );
                      },
                    )),
                  ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Visibility(
                visible: _clicked,
                child: Column(
                  children: [
                    ValueListenableBuilder<ProgressBarState>(
                      valueListenable: progressNotifier,
                      builder: (_, value, __) {
                        return ProgressBar(
                          onSeek: seek,
                          progress: value.current,
                          buffered: value.buffered,
                          total: value.total,
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ValueListenableBuilder<RepeatState>(
                          valueListenable: repeatButtonNotifier,
                          builder: (context, value, child) {
                            Icon icon;
                            switch (value) {
                              case RepeatState.off:
                                icon = Icon(Icons.repeat, color: Colors.grey);
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
                              onPressed:
                              (isFirst) ? null : onPreviousSongButtonPressed,
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
                                  child: const CircularProgressIndicator(),
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
                              onPressed: (isLast) ? null : onNextSongButtonPressed,
                            );
                          },
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: isShuffleModeEnabledNotifier,
                          builder: (context, isEnabled, child) {
                            return IconButton(
                              icon: (isEnabled)
                                  ? Icon(Icons.shuffle)
                                  : Icon(Icons.shuffle, color: Colors.grey),
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
          ],
        ),
      ),
    );
  }
}

List<Map> searchDataList = [];
List<Map> tmpDataList = [];
