import 'dart:async';

import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import 'global/components.dart';
import 'global/theme.dart';
import 'pages/bottom_bar_nav/bottom_bar_navigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {

    /*<----------------------  Animation Controller  ------------------------>*/

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController.forward();

    /*<----------------------  Page Transition  ------------------------>*/

    Timer.periodic(Duration(seconds: 4), (timer) {
      Navigator.pushReplacement(
        context,
        Components.pageTransition(
          ThemeConsumer(child: BottomBarNavigation()),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Text(
            "سلام",
            style: Theme.of(context).textTheme.headline3.copyWith(
                fontFamily: 'hadith',
                color: (ThemeProvider.themeOf(context).data == lightThemee)
                    ? Theme.of(context).primaryColor
                    : Colors.white),
          ),
        ),
      ),
    );
  }
}
