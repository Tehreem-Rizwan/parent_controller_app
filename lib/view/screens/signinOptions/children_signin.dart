import 'package:flutter/material.dart';

class ChildrenSignIn extends StatefulWidget {
  const ChildrenSignIn({super.key});

  @override
  State<ChildrenSignIn> createState() => _ChildrenSignInState();
}

class _ChildrenSignInState extends State<ChildrenSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Children Sign In"),
        ),
        body: Column(
          children: [Container(), Container()],
        ));
  }
}
