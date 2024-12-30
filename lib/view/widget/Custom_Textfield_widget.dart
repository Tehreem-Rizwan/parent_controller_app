// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styling.dart';
import 'Custom_text_widget.dart';

class CustomTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String hintText;
  final bool isIcon;

  const CustomTextField({
    Key? key,
    this.onChanged,
    this.controller,
    required this.hintText,
    this.isIcon = true,
    required String labelText,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: w(context, 400),
      height: h(context, 48),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(h(context, 8)),
        border: Border.all(
          color: kPrimaryColor,
          width: w(context, 1),
        ),
        color: kSecondaryColor,
      ),
      child: Padding(
        padding: only(
          context,
          left: 16,
          top: widget.isIcon ? 0 : 6,
          bottom: widget.isIcon ? 0 : 6,
        ),
        child: TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: f(context, 15),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: kPrimaryColor.withOpacity(0.5),
              fontSize: f(context, 15),
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: widget.isIcon
                ? Padding(
                    padding: all(context, 12),
                    // child: CommonImageView(
                    //   imagePath: Assets.imagesCalendar,
                    //   fit: BoxFit.contain,
                    //   height: 20,
                    //   width: 20,
                    // ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class CustomTextField2 extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String hintText;
  final bool isIcon;

  const CustomTextField2({
    Key? key,
    this.onChanged,
    this.controller,
    required this.hintText,
    this.isIcon = false,
  }) : super(key: key);

  @override
  _CustomTextField2State createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  bool _isObscure = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w(context, 400),
      height: h(context, 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(h(context, 8)),
        border: Border.all(
          color: kborderColor,
          width: w(context, 1),
        ),
        color: Color(0xffF6F6F6),
      ),
      child: Padding(
        padding: only(
          context,
          left: 16,
          top: widget.isIcon ? 2 : 0,
        ),
        child: TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          obscureText: widget.isIcon ? _isObscure : false,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: f(context, 15),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Color(0xffBDBDBD),
              fontSize: f(context, 15),
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: widget.isIcon
                ? Padding(
                    padding: only(context, top: 12, right: 16),
                    child: CustomText(
                      text: _isObscure ? "Show" : 'Hide',
                      size: 16,
                      color: kTertiaryColor,
                      weight: FontWeight.w500,
                      onTap: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class CustomTextField3 extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String hintText;
  final bool isIcon;
  final int maxLines;

  const CustomTextField3(
      {Key? key,
      this.onChanged,
      this.controller,
      required this.hintText,
      this.isIcon = false,
      this.maxLines = 1})
      : super(key: key);

  @override
  State<CustomTextField3> createState() => _CustomTextField3State();
}

class _CustomTextField3State extends State<CustomTextField3> {
  bool _isObscure = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w(context, double.maxFinite),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(h(context, 8)),
        border: Border.all(
          color: kborderColor,
          width: w(context, 1),
        ),
        color: Color(0xffF6F6F6),
      ),
      child: Padding(
        padding: only(
          context,
          left: 16,
          top: widget.isIcon ? 6 : 0,
          bottom: widget.isIcon ? 6 : 0,
        ),
        child: TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          obscureText: widget.isIcon ? _isObscure : false,
          maxLines: widget.maxLines,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: f(context, 15),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Color(0xffBDBDBD),
              fontSize: f(context, 15),
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: widget.isIcon
                ? IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    iconSize: 18,
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class CustomCalenderTextField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String hintText;

  const CustomCalenderTextField({
    Key? key,
    this.onChanged,
    this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w(context, 400),
      height: h(context, 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(h(context, 8)),
        border: Border.all(
          color: kborderColor,
          width: w(context, 1),
        ),
        color: Color(0xffF6F6F6),
      ),
      child: Padding(
        padding: only(
          context,
          left: 10,
          top: 3,
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: f(context, 15),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color(0xffBDBDBD),
              fontSize: f(context, 15),
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: Padding(
              padding: all(context, 15),
              // child: CommonImageView(
              //   imagePath: Assets.imagesCalendericon,
              //   fit: BoxFit.contain,
              //   width: 20,
              //   height: 20,
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
