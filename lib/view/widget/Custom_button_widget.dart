import 'package:flutter/material.dart';
import '../../../constants/app_styling.dart';
import '../../constants/app_colors.dart';
import 'Custom_text_widget.dart';
import 'common_image_view_widget.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final FontWeight fontWeight;
  final double textSize;
  final double width;
  final double height;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.buttonText,
    this.backgroundColor = kTertiaryColor,
    this.textColor = kSecondaryColor,
    this.borderRadius = 100.0,
    this.fontWeight = FontWeight.w600,
    this.textSize = 16.0,
    this.width = double.infinity,
    this.height = 51.0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w(context, width),
        height: h(context, height),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(h(context, borderRadius)),
          color: backgroundColor,
        ),
        child: Center(
          child: CustomText(
            text: buttonText,
            size: textSize,
            weight: fontWeight,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  final double borderRadius;
  final FontWeight fontWeight;
  final double textSize;
  final double width;
  final double height;
  final VoidCallback onTap;

  const CustomButton2({
    Key? key,
    required this.text,
    this.backgroundColor = kSecondaryColor,
    this.textColor = kTertiaryColor,
    this.borderColor = kTertiaryColor,
    this.borderRadius = 100.0,
    this.fontWeight = FontWeight.w500,
    this.textSize = 16.0,
    this.width = 400.0,
    this.height = 50.0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w(context, width),
        height: h(context, height),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(h(context, borderRadius)),
            color: backgroundColor,
            border: Border.all(color: borderColor)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: text,
              size: textSize,
              weight: fontWeight,
              color: textColor,
              paddingLeft: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton3 extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final FontWeight fontWeight;
  final double textSize;
  final double width;
  final double height;
  final VoidCallback onTap;
  final String? imagePath; // Make imagePath nullable

  const CustomButton3({
    Key? key,
    required this.buttonText,
    this.backgroundColor = kTertiaryColor,
    this.textColor = kSecondaryColor,
    this.borderRadius = 12.0,
    this.fontWeight = FontWeight.w600,
    this.textSize = 16.0,
    this.width = double.infinity,
    this.height = 51.0,
    required this.onTap,
    this.imagePath, // Add imagePath as optional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w(context, width),
        height: h(context, height),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(h(context, borderRadius)),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Padding(
                padding: only(context, right: 10),
                child: CommonImageView(
                  imagePath: imagePath!,
                  fit: BoxFit.contain,
                  height: 24,
                  width: 24,
                ),
              ),
            CustomText(
              text: buttonText,
              size: textSize,
              weight: fontWeight,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
