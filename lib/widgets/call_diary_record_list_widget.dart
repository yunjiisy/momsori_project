import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

Future<List<Map>> callDiaryRecordListWidget(DateTime dateTime) async {
  List<Map> categoryList = [];
  List<Map> recordList = [];
  List<Map> tmpList = [];
  List<Map> selectRecordList = [];
  categoryList.clear();
  recordList.clear();
  tmpList.clear();
  selectRecordList.clear();

  String diaryDate = DateFormat('yy년 MM월 dd일').format(dateTime);

  var tempDir = await getExternalStorageDirectory();
  Directory dir = Directory(tempDir!.path);
  List<FileSystemEntity> entries = dir.listSync(recursive: false).toList();
  categoryList.add({
    "name": '모든 녹음',
    "path": dir.path,
  });
  entries.whereType<Directory>().forEach((element) {
    String tmpString = element.path
        .substring(element.parent.path.length + 1, element.path.length);

    categoryList.add({
      "name": tmpString,
      "path": '${dir.path}/$tmpString',
    });
  });

  categoryList.forEach((element) {
    Directory dir = Directory(element["path"]);
    List<FileSystemEntity> entries = dir.listSync(recursive: false).toList();
    entries.whereType<File>().forEach((element) {
      var tmpString = element.path
          .substring(element.parent.path.length + 1, element.path.length);
      tmpString = tmpString.substring(0, tmpString.length - 4);
      File tmpFile = File(element.path);
      String date =
          DateFormat('yy년 MM월 dd일').format(tmpFile.statSync().modified);
      recordList.add({
        "name": tmpString,
        "path": element.path,
        "checked": false,
        "clicked": false,
        "date": date,
        "uri": element.uri,
        "parent": element.parent.path,
      });
    });
  });

  selectRecordList.clear();
  tmpList.addAll(recordList);
  tmpList.forEach((element) {
    String recordDate = element["date"];
    if (recordDate == diaryDate) {
      selectRecordList.add(element);
    }
  });
  return selectRecordList;
}
