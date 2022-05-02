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
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/background/tutorial.png"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/background/tutorial1.png"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/background/tutorial2.png"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/background/tutorial3.png"),
                          fit: BoxFit.cover)),
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
                          fontSize: 18,
                          color: Colors.white,
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
                    margin: _index == 3
                        ? EdgeInsets.only(left: width * 0.36, top: width * 0.05)
                        : EdgeInsets.only(
                            left: width * 0.36, top: width * 0.05),
                    child: _myCircleStatus(_index),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: width * 0.09,
                      right: width * 0.09,
                      top: height * 0.8,
                      bottom: height * 0.02,
                    ),
                    height: height * 0.07,
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
                  // Container(
                  //   margin: _index == 3
                  //       ? EdgeInsets.only(
                  //           left: width * 0.36,
                  //         )
                  //       : EdgeInsets.only(
                  //           left: width * 0.36,
                  //         ),
                  //   child: _myCircleStatus(_index),
                  // ),
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
              color: Color.fromARGB(255, 255, 234, 234),
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
              color: Color.fromARGB(255, 255, 234, 234),
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
              color: Color.fromARGB(255, 255, 234, 234),
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
      return Container();
  }
}
