// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parental_control_app/constants/app_images.dart';
import 'package:parental_control_app/constants/app_styling.dart';
import 'package:parental_control_app/view/screens/home/home.dart';
import 'package:parental_control_app/view/screens/signinOptions/signin_options.dart';
import '../../../constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreenHandler();
  }

  void splashScreenHandler() {
    Timer(
      Duration(seconds: 5),
      () => Get.offAll(() => signInOptions()
          // Home(
          //       title: "Screen Time Controller",
          //     )
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: kSecondaryColor,
        ),
        child: Center(
          child: Image(
            image: AssetImage(Assets.imagesLogoParentalControll),
            fit: BoxFit.contain,
            height: h(context, 241),
            width: w(context, 200),
          ),
        ),
      ),
    );
  }
}
