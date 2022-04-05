import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

class RecordListController extends GetxController {
  callDirectoryList() async {
    var tempDir = await getExternalStorageDirectory();
    var directoryEx =
        Directory('${tempDir!.parent.parent.parent.parent.path}/momsound/');
    List<FileSystemEntity> entries = await directoryEx.list().toList();
    return entries;
  }

  List<Map> categoryData = [
    {'name' : '모든 녹음', 'path' : '/storage/emulate/0/momsound/', 'checked' : false},
  ];
  List<String> categories = [
    '+ 카테고리 추가',
  ];

  int categoryIndex = 0;
  String category = '전체 ▼';

  addList(String newCategory) {
    categories.add(newCategory);
    update();
  }

  deleteList() {
    categories.removeLast();
    update();
  }

  changeIndex(int index) {
    categoryIndex = index;
    update();
  }

  changeCategory(String newCategory) {
    category = newCategory;
    update();
  }
}
