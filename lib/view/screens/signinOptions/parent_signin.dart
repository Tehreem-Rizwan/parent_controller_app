import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parental_control_app/constants/app_colors.dart';
import 'package:parental_control_app/constants/app_styling.dart';
import 'package:get/get.dart';
import 'package:parental_control_app/model/parent.dart';
import 'package:parental_control_app/view/screens/home/home.dart';

class ParentSignIn extends StatefulWidget {
  final String title;
  final bool isParent;
  const ParentSignIn({super.key, required this.title, required this.isParent});

  @override
  State<ParentSignIn> createState() => _ParentSignInState();
}

class _ParentSignInState extends State<ParentSignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _parentcodeController = TextEditingController();

  bool issignUp = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.title} Sign In"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!widget.isParent)
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: kborderColor)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: _parentcodeController,
                    decoration: InputDecoration(
                        hintText: "Enter parent code",
                        border: InputBorder.none),
                  ),
                ),
              ),
            if (!widget.isParent)
              SizedBox(
                height: h(context, 20),
              ),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: kborderColor)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: "Enter email", border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              height: h(context, 20),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: kborderColor)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: "Enter password", border: InputBorder.none),
                ),
              ),
            ),
            if (!issignUp)
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "User Credential does not match, please signup",
                  style: TextStyle(color: Colors.red),
                ),
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
                  onPressed: () async {
                    try {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        UserCredential credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);

                        if (credential.user != null) {
                          print('USER CREDENTIAL');
                          Get.to(() => Home(title: "Screen Time Controller"));
                        } else {
                          setState(() {
                            issignUp = !issignUp;
                          });
                        }
                      }
                    } catch (e) {
                      print(e);
                      setState(() {
                        issignUp = !issignUp;
                      });
                    }
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
                  onPressed: () async {
                    try {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        UserCredential credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);
                        print(credential.user);
                        if (credential.user != null) {
                          setState(() {
                            _emailController.text = '';
                            _passwordController.text = '';
                          });
                          Parent parent = Parent(
                              credential.user!.uid, "", "", "", [], "", "");
                          await FirebaseFirestore.instance
                              .collection('parents')
                              .add(parent.toJSON());
                        } else {
                          setState(() {
                            issignUp = !issignUp;
                          });
                        }
                      }
                    } catch (e) {
                      print(e);
                      setState(() {
                        issignUp = !issignUp;
                      });
                    }
                    //   Get.to(() => ChildrenSignIn());
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: kSecondaryColor, fontSize: 18),
                  )),
            ),
          ],
        ));
  }
}
