// parent_signin.dart
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parental_control_app/constants/app_colors.dart';
import 'package:parental_control_app/constants/app_styling.dart';
import 'package:parental_control_app/model/children.dart';
import 'package:parental_control_app/model/parent.dart';
import 'package:parental_control_app/view/screens/home/home.dart';

class ParentSignIn extends StatefulWidget {
  final String title;
  final bool isParent;
  const ParentSignIn({Key? key, required this.title, required this.isParent})
      : super(key: key);

  @override
  State<ParentSignIn> createState() => _ParentSignInState();
}

class _ParentSignInState extends State<ParentSignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _parentcodeController = TextEditingController();
  bool _isSignUpError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _parentcodeController.dispose();
    super.dispose();
  }

  String generateRandomCode() {
    const String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const int codeLength = 6;
    final Random random = Random();
    return String.fromCharCodes(
      Iterable.generate(codeLength,
          (_) => alphabet.codeUnitAt(random.nextInt(alphabet.length))),
    );
  }

  Future<String> checkParentCode(String parentCode) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("parents")
        .where('parentCode', isEqualTo: parentCode)
        .get();
    return querySnapshot.docs.isNotEmpty
        ? querySnapshot.docs.first['userId']
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title} Sign In"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!widget.isParent)
                _buildTextField(
                  context: context,
                  controller: _parentcodeController,
                  hintText: "Enter parent code",
                ),
              if (!widget.isParent) SizedBox(height: h(context, 20)),
              _buildTextField(
                context: context,
                controller: _emailController,
                hintText: "Enter email",
              ),
              SizedBox(height: h(context, 20)),
              _buildTextField(
                context: context,
                controller: _passwordController,
                hintText: "Enter password",
                obscureText: true,
              ),
              if (_isSignUpError)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "User Credential does not match, please signup",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: h(context, 40)),
              _buildActionButton(
                context: context,
                title: "Sign in",
                backgroundColor: Colors.green,
                onPressed: _signIn,
              ),
              SizedBox(
                  height: h(context, 40), child: Center(child: Text("OR"))),
              _buildActionButton(
                context: context,
                title: "Sign Up",
                backgroundColor: Colors.blue,
                onPressed: _signUp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: kborderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration:
              InputDecoration(hintText: hintText, border: InputBorder.none),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String title,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Container(
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
    );
  }

  Future<void> _signIn() async {
    try {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (credential.user != null) {
          Get.to(() =>
              Home(title: "Screen Time Controller", isParent: widget.isParent));
        } else {
          setState(() => _isSignUpError = true);
        }
      }
    } catch (e) {
      print(e);
      setState(() => _isSignUpError = true);
    }
  }

  Future<void> _signUp() async {
    try {
      if (widget.isParent &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        UserCredential credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (credential.user != null) {
          await _registerUser(credential.user!.uid, credential);
          Get.to(() =>
              Home(title: "Screen Time Controller", isParent: widget.isParent));
          Parent parent = Parent(credential.user!.uid, "", "", "", "", "", [],
              generateRandomCode());
          await FirebaseFirestore.instance
              .collection('parents')
              .doc(credential.user!.uid)
              .set(parent.toJSON());
        }
      } else {
        String parentId =
            await checkParentCode(_parentcodeController.text.trim());
        if (parentId.isNotEmpty) {
          UserCredential credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
          Children child =
              Children(credential.user!.uid, '', '', '', '', '', '', []);
          await FirebaseFirestore.instance
              .collection('children')
              .add(child.toJSON());
        }
      }
    } catch (e) {
      print(e);
      setState(() => _isSignUpError = true);
    }
  }

  Future<void> _registerUser(String userId, UserCredential credential) async {
    if (widget.isParent) {
    } else {}
  }
}
