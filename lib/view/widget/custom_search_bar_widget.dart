import 'package:flutter/material.dart';
import '../../constants/app_styling.dart';

class CustomSearchBar extends StatelessWidget {
  final double width;
  final String hintText;

  const CustomSearchBar({
    Key? key,
    this.width = double.infinity,
    this.hintText = 'Search',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w(context, width),
      decoration: BoxDecoration(
        color: const Color(0xffF0F2F3),
        borderRadius: BorderRadius.circular(h(context, 12)),
      ),
      child: Padding(
        padding: symmetric(
          context,
          horizontal: 14,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CommonImageView(
            //   imagePath: Assets.imagesSearch,
            //   fit: BoxFit.contain,
            //   height: h(context, 20),
            //   width: w(context, 20),
            // ),
            SizedBox(
              width: w(context, 10),
            ),
            Expanded(
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    hintStyle: const TextStyle(
                      color: Color(0xff9D9D9D),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
