import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // or your auth package
import 'package:parental_control_app/constants/app_images.dart';
import 'package:parental_control_app/constants/app_styling.dart';
import 'package:parental_control_app/view/screens/home/home.dart';
import 'package:parental_control_app/view/screens/signinOptions/signin_options.dart';
import '../../../constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: kSecondaryColor,
        ),
        child: Center(
          child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Get.offAll(() => Home(title: "Screen Time Controller"));
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Get.offAll(() => signInOptions());
                });
              }
              return Image(
                image: AssetImage(Assets.imagesLogoParentalControll),
                fit: BoxFit.contain,
                height: h(context, 241),
                width: w(context, 200),
              );
            },
          ),
        ),
      ),
    );
  }
}
