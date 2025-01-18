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
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(),
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    onPressed: () {
                      Get.to(() => ParentSignIn(
                            title: 'Parent',
                            isParent: true,
                          ));
                    },
                    child: Text(
                      "Login as Parent",
                      style: TextStyle(color: kSecondaryColor, fontSize: 18),
                    )),
              ),
            ),
            SizedBox(
              height: h(context, 40),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(),
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    onPressed: () {
                      Get.to(() => ParentSignIn(
                            title: 'Child',
                            isParent: false,
                          ));
                    },
                    child: Text(
                      "Login as Child",
                      style: TextStyle(color: kSecondaryColor, fontSize: 18),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
