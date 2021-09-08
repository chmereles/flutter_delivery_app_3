import 'package:flutter/material.dart';

class TypesWidget extends StatelessWidget {
  const TypesWidget({
    Key? key,
    required this.types,
    this.fontSize = 12,
    this.iconData,
  }) : super(key: key);

  final List<String> types;
  final IconData? iconData;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: fontSize);
    final iconSize = fontSize * 0.5;

    return Row(
      // children: [for (var type in types) Text('$type - ')],
      children: [
        for (var i = 0; i < types.length; i++)
          if (i == 0 && iconData != null)
            Row(
              children: [
                Icon(
                  iconData,
                  size: fontSize,
                ),
                const SizedBox(width: 3),
              ],
            )
          else if (i != types.length - 1)
            Row(
              children: [
                if (i == 0)
                  Text(
                    '${types[i]} ',
                    style: textStyle,
                  )
                else
                  Text(' ${types[i]} ', style: textStyle),
                Icon(
                  Icons.fiber_manual_record,
                  size: iconSize,
                ),
              ],
            )
          else
            Text('${types[i]}', style: textStyle)
      ],
    );
  }
}
