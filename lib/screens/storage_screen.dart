import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:momsori/screens/category_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:momsori/getx_controller/record_list_controller.dart';

List<Map> fileDataList = [];

class StorageScreen extends StatefulWidget {
  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  bool _editMode = false;
  final textController = TextEditingController();
  final rlController = Get.put<RecordListController>(RecordListController());

  ListTile listTileWidget(int index) {
    return ListTile(
      leading: SvgPicture.asset('assets/background/storage_folder.svg'),
      title: Text(
        rlController.categoryData[index]["name"],
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      // subtitle: Text(
      //     rlController.categoryData[index]["date"]),
      onTap: () {
        Get.to(() => CategoryScreen(),
            arguments: index, transition: Transition.downToUp);
      },
    );
  }

  void callCategoryList() async {
    var tempDir = await getExternalStorageDirectory();
    var dir = Directory(tempDir!.path);
    dir.create(recursive: true);
    List<FileSystemEntity> entries = dir.listSync(recursive: false).toList();
    setState(() {
      rlController.categoryData.clear();
      rlController.categoryData.add({
        "name": '모든 녹음',
        "path": dir.path,
        "checked": false,
      });
      entries.whereType<Directory>().forEach((element) {
        var tmpString = element.path
            .substring(element.parent.path.length + 1, element.path.length);

        rlController.categoryData.add({
          "name": tmpString,
          "path": '${dir.path}/$tmpString',
          "checked": false,
        });
      });
    });
    callCategories();
    setState(() {});
  }

  void callCategories() {
    rlController.categories.clear();
    rlController.categoryData.forEach((element) {
      rlController.categories.add(element["name"]);
    });
    rlController.categories.add('+ 카테고리 추가');
    rlController.category = '전체 ▼';
  }

  void createCategory(String category) async {
    var tempDir = await getExternalStorageDirectory();
    Directory directory = Directory('${tempDir!.path}/$category');
    directory.create(recursive: true);
    setState(() {});
  }

  void deleteCategory() {
    Directory dir;
    List toDelete = [];
    rlController.categoryData.forEach((element) {
      if (element["checked"] == true) {
        toDelete.add(element);
        dir = Directory(element["path"]);
        dir.delete(recursive: true);
      }
    });
    rlController.categoryData
        .removeWhere((element) => toDelete.contains(element));
    setState(() {});
  }

  void renameCategory(String category) {
    setState(() {
      rlController.categoryData.forEach((element) {
        if (element["checked"] == true) {
          Directory dir = Directory(element["path"]);
          category = dir.parent.path + '/$category';
          dir.rename(category);
          element["name"] = category;
          element["path"] = dir.path;
          element["checked"] = false;
        }
      });
    });
  }

  void createCategoryDialog() {
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
                      Navigator.pop(context);
                    }),
                new CupertinoButton(
                    child: Text(
                      "확인",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        createCategory(textController.text);
                        textController.clear();
                        callCategoryList();
                      });
                      setState(() {});
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }

  void renameCategoryDialog() {
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
                      callCategoryList();
                      setState(() {});
                      print('OK');
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }

  void deleteCategoryDialog() {
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
                  Text("해당 파일드을 삭제하시겠습니까?"),
                  Text("해당 녹음들은 영구 삭제됩니다."),
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
                      deleteCategory();
                      setState(() {});
                      callCategoryList();
                      print('delete file ok');
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    setState(() {
      callCategoryList();
    });
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rlController = Get.put<RecordListController>(RecordListController());

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background/storage_background.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GetBuilder<RecordListController>(
          init: rlController,
          builder: (context) => Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: TextButton(
                          onPressed: () {
                            callCategoryList();
                            setState(() {});
                            print('dfgxdsf');
                          },
                          child: Text(
                            '저장소',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.06,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              print('edit mode : $_editMode');
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
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: width * 0.03, top: height * 0.01),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/icons/storage_icon2.png',
                          scale: 0.98,
                        ),
                      ],
                    ),
                  ),
                ),

                // Storage, Search, Edit
                Expanded(
                  child: _editMode == false
                      ? Container(
                          child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: rlController.categoryData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Column(
                                children: [
                                  listTileWidget(index),
                                  Container(
                                    height: 1.0,
                                    width: width * 0.86,
                                    color: Color.fromARGB(255, 239, 212, 212),
                                  )
                                ],
                              ),
                            );
                          },
                        ))
                      : Container(
                          child: ListView.builder(
                          itemCount: rlController.categoryData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(
                                    rlController.categoryData[index]["name"],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                  value: rlController.categoryData[index]
                                      ["checked"],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      rlController.categoryData[index]
                                              ["checked"] =
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
                              deleteCategoryDialog();
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
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            child: TextButton(
                              onPressed: () {
                                createCategoryDialog();
                                callCategoryList();
                                setState(() {});
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
        ),
      ),
    );
  }
}
