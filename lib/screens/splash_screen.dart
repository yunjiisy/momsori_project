import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'tutorial_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background/splashScreen.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedSplashScreen(
          backgroundColor: Colors.transparent,
          splash: Text(
            ' ',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          splashIconSize: 200,
          nextScreen: TutorialScreen(),
          // nextScreen: LoginScreen(),
          duration: 2000,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
        ),
      ),
    );
  }
}
