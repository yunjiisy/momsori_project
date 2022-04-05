import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

class RecordListController extends GetxController {
  List<Map> categoryData = [];
  List<String> categories = [];

  int categoryIndex = 0;
  String category = '전체 ▼';

  addList(String newCategory) async {
    var tempDir = await getExternalStorageDirectory();
    var dir =
    Directory('${tempDir!.parent.parent.parent.parent.path}/momsound/');
    categories.add(newCategory);
    categoryData.add({
      'name' : newCategory,
      'path' : '${dir.path}/$newCategory',
      'checked' : false,
    });
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
