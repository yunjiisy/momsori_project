import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:momsori/widgets/contants.dart';
import 'package:momsori/getx_controller/user_controller.dart';

import 'main_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = Get.find<UserController>();
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
                Image.asset(
                  'assets/icons/확인용.gif',
                  height: 0.35 * height,
                ),
                TextFormField(
                  onChanged: (nextText) {
                    setState(() {
                      _mText = nextText;
                    });
                  },
                  maxLength: 6,
                  cursorColor: Color(0xFFFFA9A9),
                  decoration: InputDecoration(
                    hintText: '${user.userName}',
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
                  onChanged: (nextText) {
                    setState(() {
                      _bText = nextText;
                    });
                  },
                  maxLength: 6,
                  cursorColor: Color(0xFFFFA9A9),
                  decoration: InputDecoration(
                    hintText: '${user.babyNickname}',
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
                  onChanged: (nextText) {
                    if (nextText.length == 4) nextText += '.';
                    if (nextText.length == 7) nextText += '.';
                    setState(() {
                      _dText = nextText;
                      print(nextText);
                    });
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // FilteringTextInputFormatter.allow(RegExp("[0-9\\.]")),
                    TextInputMask(
                      mask: '9999.99.99',
                    ),
                  ],
                  cursorColor: Color(0xFFFFA9A9),
                  decoration: InputDecoration(
                    hintText: '${user.babyBirth}',
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
                    style: ButtonStyle(
                        //shape: MaterialStateProperty.all(Border),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Color.fromARGB(255, 189, 189, 189);
                      } else {
                        return Color(0xFFFFA9A9);
                      }
                    })),
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
