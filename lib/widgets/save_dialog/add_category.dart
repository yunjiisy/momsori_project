import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:momsori/getx_controller/record_list_controller.dart';
import 'package:momsori/widgets/save_dialog/save_dialog.dart';

addCategory(BuildContext context1) {
  final controller = Get.put(RecordListController());
  String newCategory = '';

  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(1),
      child: Container(
        width: double.infinity,
        height: 145.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        padding: EdgeInsets.fromLTRB(15.w, 15.h, 17.w, 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '카테고리 추가',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            TextFormField(
              onChanged: (nextText) {
                setState(() {
                  newCategory = nextText;
                });
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    '취소',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Color(0xFFFFA9A9),
                    ),
                  ),
                ),
                Text(
                  '|',
                  style: TextStyle(
                    color: Color(0xffdadada),
                    fontSize: 18.sp,
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.deleteList();
                    controller.addList(newCategory);
                    controller.addList('+ 카테고리 추가');
                    Get.back();
                  },
                  child: Text(
                    '확인',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Color(0xFFFFA9A9),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  });
}
