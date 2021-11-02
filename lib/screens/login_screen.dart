import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                width: 600,
                height: 600,
                padding: EdgeInsets.only(top: 100, bottom: 100),
                child: Image.network(
                    'https://images.unsplash.com/photo-1496174742515-d2146dcf8e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MjF8fGN1dGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CircleAvatar(
                  //   child: Image(
                  //     image: AssetImage('assets/images/kakao_logo.png'),
                  //   ),
                  // ),
                  SizedBox(
                    width: 30,
                  ),
                  // CircleAvatar(
                  //   child: Image(
                  //     image: AssetImage('assets/images/google_logo.png'),
                  //   ),
                  // ),
                  SizedBox(
                    width: 30,
                  ),
                  // CircleAvatar(
                  //   child: Image(
                  //     image: AssetImage('assets/images/naver_logo.jpg'),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
