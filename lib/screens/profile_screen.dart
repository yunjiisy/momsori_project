import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:momsori/widgets/contants.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                    ),
                    Text(
                      '프로필 수정',
                      style: kTitleStyle,
                    ),
                  ],
                ),
                SvgPicture.asset(
                  'assets/images/check.svg',
                  height: 0.4 * height,
                ),
                TextFormField(
                  onChanged: (nextText) {},
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ],
                  maxLength: 6,
                  cursorColor: Color(0xFFFFA9A9),
                  decoration: InputDecoration(
                    hintText: '엄마 이름을 입력해주세요',
                    border: InputBorder.none,
                    counterText: '',
                    fillColor: Color(0xFFE5E5E5),
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                TextFormField(
                  onChanged: (nextText) {},
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ],
                  maxLength: 6,
                  cursorColor: Color(0xFFFFA9A9),
                  decoration: InputDecoration(
                    hintText: '태아의 태명을 입력해주세요',
                    border: InputBorder.none,
                    counterText: '',
                    fillColor: Color(0xFFE5E5E5),
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                TextFormField(
                  onChanged: (nextText) {},
                  cursorColor: Color(0xFFFFA9A9),
                  decoration: InputDecoration(
                    hintText: '태아의 출생 예정일',
                    border: InputBorder.none,
                    counterText: '',
                    fillColor: Color(0xFFE5E5E5),
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                  height: height * 0.08,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onSurface: Color(0xFFFFA9A9),
                    ),
                    onPressed: () {},
                    child: Text(
                      '확인',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
