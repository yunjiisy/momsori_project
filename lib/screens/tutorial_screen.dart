import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momsori/screens/nickname_screen.dart';

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              children: [
                Container(
                  color: Colors.grey,
                  margin: EdgeInsets.only(
                    top: height * 0.1,
                    bottom: height * 0.2,
                  ),
                  child: Center(
                    child: Text(
                      '튜토리얼1',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFA9A9),
                        fontFamily: 'NotoSansKR',
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey,
                  margin: EdgeInsets.only(
                    top: height * 0.1,
                    bottom: height * 0.2,
                  ),
                  child: Center(
                    child: Text(
                      '튜토리얼2',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFA9A9),
                        fontFamily: 'NotoSansKR',
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey,
                  margin: EdgeInsets.only(
                    top: height * 0.1,
                    bottom: height * 0.2,
                  ),
                  child: Center(
                    child: Text(
                      '튜토리얼3',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFA9A9),
                        fontFamily: 'NotoSansKR',
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey,
                  margin: EdgeInsets.only(
                    top: height * 0.1,
                    bottom: height * 0.2,
                  ),
                  child: Center(
                    child: Text(
                      '튜토리얼4',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFA9A9),
                        fontFamily: 'NotoSansKR',
                      ),
                    ),
                  ),
                ),
              ],
              onPageChanged: (index) {
                setState(() {
                  _index = index;
                });
              },
            ),
            if (_index != 3)
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.to(
                      NicknameScreen(),
                      transition: Transition.cupertino,
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 50,
                    child: Center(
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSansKR',
                          fontSize: 18,
                          color: Color(0xFFFFA9A9),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            else
              Text(''),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: height * 0.8,
                      bottom: height * 0.02,
                    ),
                    height: height * 0.08,
                    child: _index == 3
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFFFA9A9),
                            ),
                            onPressed: () {
                              Get.to(
                                NicknameScreen(),
                                transition: Transition.fadeIn,
                              );
                            },
                            child: Text(
                              '시작하기',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'NotoSansKR',
                                fontSize: 18,
                              ),
                            ),
                          )
                        : Text(''),
                  ),
                  Container(
                    margin: _index == 3
                        ? EdgeInsets.only(
                            left: width * 0.36,
                          )
                        : EdgeInsets.only(
                            left: width * 0.36,
                          ),
                    child: _myCircleStatus(_index),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _myCircleStatus(int index) {
    if (index == 0)
      return Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
        ],
      );
    else if (index == 1)
      return Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
        ],
      );
    else if (index == 2)
      return Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
        ],
      );
    else
      return Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
          ),
        ],
      );
  }
}
