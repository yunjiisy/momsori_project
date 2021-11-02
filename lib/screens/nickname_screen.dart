import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:momsori/getx_controller/user_controller.dart';
import 'package:momsori/screens/main_screen.dart';
import 'package:momsori/screens/tutorial_screen.dart';
import 'package:momsori/widgets/contants.dart';

class NicknameScreen extends StatefulWidget {
  @override
  _NicknameScreenState createState() => _NicknameScreenState();
}

class _NicknameScreenState extends State<NicknameScreen> {
  String _mText = '';
  String _bText = '';
  String _dText = '';

  final userController = Get.put<UserController>(
    UserController(),
    permanent: true,
  );

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
                          Get.off(TutorialScreen());
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                    ),
                    Text('정보등록', style: kTitleStyle),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  onChanged: (nextText) {
                    setState(() {
                      _mText = nextText;
                    });
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ],
                  maxLength: 6,
                  cursorColor: Color(0xFFFFA9A9),
                  decoration: InputDecoration(
                    hintText: '엄마 이름을 입력해주세요',
                    counterText: '',
                    fillColor: Color(0xFFE5E5E5),
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE5E5E5))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE5E5E5))),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                TextFormField(
                  onChanged: (nextText) {
                    setState(() {
                      _bText = nextText;
                    });
                  },
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
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE5E5E5))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE5E5E5))),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                TextFormField(
                  onChanged: (nextText) {
                    if (nextText.length == 4) nextText += '.';
                    if (nextText.length == 7) nextText += '.';
                    setState(() {
                      _dText = nextText;
                      print(nextText);
                    });
                  },
                  maxLength: 10,
                  cursorColor: Color(0xFFFFA9A9),
                  decoration: InputDecoration(
                    hintText: '태아의 출생 예정일',
                    border: InputBorder.none,
                    counterText: '',
                    fillColor: Color(0xFFE5E5E5),
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE5E5E5))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE5E5E5))),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // FilteringTextInputFormatter.allow(RegExp("[0-9\\.]")),
                    TextInputMask(
                      mask: '9999.99.99',
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Container(
                  height: height * 0.06,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Color(0xFFDADADA);
                        } else {
                          return Color(0xFFFFA9A9);
                        }
                      }),
                    ),
                    onPressed:
                        _mText != '' && _bText != '' && _dText.length == 10
                            ? () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                currentFocus.unfocus();
                                userController.updateUserName(
                                    _mText, _bText, _dText);
                                Get.offAll(
                                  () => MainScreen(),
                                  transition: Transition.fadeIn,
                                );
                              }
                            : null,
                    child: Text(
                      '다음',
                      style: TextStyle(
                        color:
                            _mText != '' && _bText != '' && _dText.length == 10
                                ? Colors.white
                                : Colors.black,
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
