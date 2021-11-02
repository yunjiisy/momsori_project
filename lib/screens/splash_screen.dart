import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'tutorial_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Text(
        'MOMSORY\nSplashScreen\n2초 후에 넘어갑니다',
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
    );
  }
}
