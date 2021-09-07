import 'package:flutter/material.dart';

class IconTextWidget extends StatelessWidget {
  const IconTextWidget({
    Key? key,
    this.color,
    this.iconColor,
    required this.iconData,
    required this.text,
    this.fontSize = 14,
    this.iconSize,
  }) : super(key: key);

  final Color? color;
  final Color? iconColor;
  final IconData iconData;
  final String text;
  final double fontSize;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final typesStyle = TextStyle(
      fontSize: fontSize,
      color: color,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          iconData,
          size: iconSize ?? fontSize * 1.35,
          color: iconColor ?? color,
        ),
        SizedBox(width: fontSize / 5),
        Text(
          text,
          style: typesStyle,
        ),
      ],
    );
  }
}
