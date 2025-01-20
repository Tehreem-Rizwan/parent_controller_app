import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Assuming Firestore is used
import 'package:parental_control_app/constants/app_images.dart';
import 'package:parental_control_app/constants/app_styling.dart';
import 'package:parental_control_app/view/screens/home/home.dart';
import 'package:parental_control_app/view/screens/signinOptions/signin_options.dart';
import '../../../constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  Future<bool> fetchIsParent(String userId) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userDoc['isParent'] ?? false;
  }

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
                final userId = snapshot.data!.uid;
                return FutureBuilder<bool>(
                  future: fetchIsParent(userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      final isParent = snapshot.data!;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Get.offAll(() => Home(
                              title: "Screen Time Controller",
                              isParent: isParent,
                            ));
                      });
                    }
                    return SizedBox.shrink(); // Placeholder widget
                  },
                );
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
