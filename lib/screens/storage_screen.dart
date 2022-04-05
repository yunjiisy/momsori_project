import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momsori/screens/category_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:momsori/getx_controller/record_list_controller.dart';

class StorageScreen extends StatefulWidget {
  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  bool _editMode = false;
  final textController = TextEditingController();
  final rlController = Get.put<RecordListController>(RecordListController());

  callCategoryList() async {
    var tempDir = await getExternalStorageDirectory();
    var dir =
        Directory('${tempDir!.parent.parent.parent.parent.path}/momsound/');
    List<FileSystemEntity> entries =
        dir.listSync(recursive: false).toList();
    rlController.categoryData.add({
      "name": '모든 녹음',
      "path": dir.path,
      "checked": false,
    });
    entries.forEach((element) {
      var tmpString = element.path
          .substring(element.parent.path.length + 1, element.path.length);

        rlController.categoryData.add({
          "name": tmpString,
          "path": '${dir.path}/$tmpString',
        "checked": false,
      });

      // rlController.categories.removeLast();
      // rlController.categories.add(tmpString);
      // rlController.categories.add('+ 카테고리 추가');
    });
  }
  deleteCategory() {
    setState(() {
      rlController.categoryData.forEach((element) {
        if (element["checked"] == true) {
          Directory dir = Directory(element["path"]);
          dir.delete();
          rlController.categoryData.remove(element);
        }
      });
    });
  }
  renameCategory(String category) {
    setState(() {
      rlController.categoryData.forEach((element) {
        if (element["checked"] == true) {
          Directory dir = Directory(element["path"]);
          dir.rename(category);
          element["name"] = category;
          element["path"] = dir.path;
          element["checked"] = false;
        }
      });
    });
  }
  createCategory(String category) async {
    var tempDir = await getExternalStorageDirectory();
    var directory = Directory(
        '${tempDir!.parent.parent.parent.parent.path}/momsound/$category/');
    directory.create(recursive: true);
    rlController.categoryData.add({
      "name": category,
      "path": '${directory.path}/$category',
      "checked": false,
    });
  }
  createCategoryDialog() {
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
                  Text("폴더 이름"),
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
                      print('Add Directory Cancel');
                      Navigator.pop(context);
                    }),
                new CupertinoButton(
                    child: Text(
                      "확인",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      createCategory(textController.text);
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
  renameCategoryDialog() {
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
                  Text("폴더 이름"),
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
                      print('Rename Directory Cancel');
                      Navigator.pop(context);
                    }),
                new CupertinoButton(
                    child: Text(
                      "확인",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      renameCategory(textController.text);
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

  @override
  void initState() {
    if(rlController.categoryData.isEmpty) callCategoryList();
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: TextButton(
                      onPressed: () {
                        if(rlController.categoryData.isEmpty) callCategoryList();
                        setState(() {});
                      },
                      child: Text(
                        '저장소',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          print('edit mode');
                          // ignore: unnecessary_statements
                          _editMode = !_editMode;
                          rlController.categoryData.forEach((element) {
                            element["checked"] = false;
                          });
                          setState(() {});
                        },
                        child: Text(
                          '편집',
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
            ),

            // Storage, Search, Edit
            Expanded(
              child: _editMode == false
                  ? Container(
                      child: ListView.builder(
                      itemCount: rlController.categoryData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListTile(
                            title: Text(
                              rlController.categoryData[index]["name"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {
                              Get.to(() => CategoryScreen(),
                                  arguments: index,
                                  transition: Transition.downToUp);
                            },
                          ),
                        );
                      },
                    ))
                  : Container(
                      child: ListView.builder(
                      itemCount: rlController.categoryData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(
                                rlController.categoryData[index]["name"],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              value: rlController.categoryData[index]
                                  ["checked"],
                              onChanged: (bool? value) {
                                setState(() {
                                  rlController.categoryData[index]["checked"] =
                                      !rlController.categoryData[index]
                                          ["checked"];
                                });
                              }),
                        );
                      },
                    )),
            ),

            _editMode
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          print('folder delete');
                          deleteCategory();
                          _editMode = !_editMode;
                          setState(() {});
                        },
                        icon: Icon(Icons.delete_forever_sharp),
                        iconSize: 40,
                        color: Color(0xFFFFA9A9),
                      ),
                      IconButton(
                        onPressed: () {
                          renameCategoryDialog();
                          print('folder rename');
                          _editMode = !_editMode;
                        },
                        icon: Icon(Icons.edit),
                        iconSize: 40,
                        color: Color(0xFFFFA9A9),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 10),
                        child: TextButton(
                          onPressed: () {
                            createCategoryDialog();
                            print('add Dialog');
                          },
                          child: Text(
                            '+ 카테고리 추가',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
