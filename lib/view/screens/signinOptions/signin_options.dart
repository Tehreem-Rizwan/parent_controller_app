import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parental_control_app/constants/app_colors.dart';
import 'package:parental_control_app/constants/app_styling.dart';
import 'package:parental_control_app/view/screens/signinOptions/children_signin.dart';
import 'package:parental_control_app/view/screens/signinOptions/parent_signin.dart';

class signInOptions extends StatefulWidget {
  const signInOptions({super.key});

  @override
  State<signInOptions> createState() => _signInOptionsState();
}

class _signInOptionsState extends State<signInOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(),
              child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () {
                    Get.to(() => ParentSignIn());
                  },
                  child: Text(
                    "Login as Parent",
                    style: TextStyle(color: kSecondaryColor, fontSize: 18),
                  )),
            ),
            SizedBox(
              height: h(context, 40),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(),
              child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () {
                    Get.to(() => ChildrenSignIn());
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(color: kSecondaryColor, fontSize: 18),
                  )),
            ),
            SizedBox(
              height: h(context, 40),
              child: Center(child: Text("OR")),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(),
              child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () {
                    Get.to(() => ChildrenSignIn());
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: kBlackColor, fontSize: 18),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
