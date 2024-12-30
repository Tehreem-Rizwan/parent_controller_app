import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styling.dart';

class CustomDropdown extends StatefulWidget {
  final List<dynamic> items;
  final dynamic selectedValue;
  final ValueChanged<dynamic>? onChanged;
  final double width;
  final String hint;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.width = 400,
    required this.hint,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: w(context, widget.width),
      height: h(context, 48),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(h(context, 8)),
        border: Border.all(
          color: kPrimaryColor,
          width: w(context, 1),
        ),
        color: kSecondaryColor,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<dynamic>(
          dropdownColor: kSecondaryColor,
          hint: Padding(
            padding: symmetric(context, horizontal: 18),
            child: Text(
              widget.hint,
              style: TextStyle(
                fontSize: f(context, 16),
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
          items: widget.items
              .map((dynamic item) => DropdownMenuItem<dynamic>(
                    value: item,
                    child: Padding(
                      padding: symmetric(context, horizontal: 18),
                      child: Text(
                        item.toString(),
                        style: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                          fontSize: f(context, 15),
                        ),
                      ),
                    ),
                  ))
              .toList(),
          value: widget.selectedValue,
          onChanged: widget.onChanged,
          icon: Padding(
            padding: only(context, right: 18),
            // child: Image.asset(
            //   Assets.imagesDropdown,
            //   height: h(context, 18),
            //   width: w(context, 16),
            // ),
          ),
        ),
      ),
    );
  }
}
