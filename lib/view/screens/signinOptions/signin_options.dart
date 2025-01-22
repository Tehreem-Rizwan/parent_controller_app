// signInOptions.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parental_control_app/constants/app_colors.dart';
import 'package:parental_control_app/constants/app_styling.dart';
import 'package:parental_control_app/view/screens/signinOptions/parent_signin.dart';

class SignInOptions extends StatelessWidget {
  const SignInOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSignInButton(
              context: context,
              title: "Login as Parent",
              backgroundColor: Colors.blue,
              onPressed: () {
                Get.to(() => ParentSignIn(title: 'Parent', isParent: true));
              },
            ),
            SizedBox(height: h(context, 40)),
            _buildSignInButton(
              context: context,
              title: "Login as Child",
              backgroundColor: Colors.yellow,
              onPressed: () {
                Get.to(() => ParentSignIn(title: 'Child', isParent: false));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInButton({
    required BuildContext context,
    required String title,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(color: kSecondaryColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
