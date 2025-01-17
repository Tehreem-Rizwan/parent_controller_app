import 'package:flutter/material.dart';
import 'package:parental_control_app/constants/app_colors.dart';
import 'package:parental_control_app/constants/app_styling.dart';

class ParentSignIn extends StatefulWidget {
  const ParentSignIn({super.key});

  @override
  State<ParentSignIn> createState() => _ParentSignInState();
}

class _ParentSignInState extends State<ParentSignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
          title: Text("Parent Sign In"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: "Enter password", border: InputBorder.none),
                ),
              ),
            ),
          ],
        ));
  }
}
