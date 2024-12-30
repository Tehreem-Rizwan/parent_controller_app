// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CircleCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CircleCheckbox({
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _CircleCheckboxState createState() => _CircleCheckboxState();
}

class _CircleCheckboxState extends State<CircleCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: kPrimaryColor,
            width: 2,
          ),
          color: widget.value ? kPrimaryColor : kSecondaryColor,
        ),
        child: widget.value
            ? Icon(
                Icons.check,
                color: kSecondaryColor,
                size: 16,
              )
            : null,
      ),
    );
  }
}
