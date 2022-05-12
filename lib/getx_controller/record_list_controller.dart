import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

class RecordListController extends GetxController {
  List<Map> categoryData = [];
  List<String> categories = [];

  int categoryIndex = 0;
  String category = '전체';

  addList(String newCategory) async {
    var tempDir = await getExternalStorageDirectory();
    var dir = Directory('${tempDir!.path}/$newCategory');
    dir.create(recursive: true);
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

  callCategoryList() async {
    var tempDir = await getExternalStorageDirectory();
    var dir = Directory(tempDir!.path);
    dir.create(recursive: true);
    List<FileSystemEntity> entries = dir.listSync(recursive: false).toList();

    categoryData.clear();
    categoryData.add({
      "name": '모든 녹음',
      "path": dir.path,
      "checked": false,
    });
    entries.whereType<Directory>().forEach((element) {
      var tmpString = element.path
          .substring(element.parent.path.length + 1, element.path.length);

      categoryData.add({
        "name": tmpString,
        "path": '${dir.path}/$tmpString',
        "checked": false,
      });
    });
    categories.clear();
    categoryData.forEach((element) {
      categories.add(element["name"]);
    });
    categories.add('+ 폴더 추가');
    update();
  }

  callCategories() {
    categories.clear();
    categoryData.forEach((element) {
      categories.add(element["name"]);
    });
    categories.add('+ 폴더 추가');
    update();
  }
}
