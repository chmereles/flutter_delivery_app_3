import 'package:flutter/material.dart';

const _iconSize = 60.0;

class BuildPinMap extends StatelessWidget {
  const BuildPinMap({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: _iconSize / 1,
            width: _iconSize / 1,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: Container(
            height: _iconSize / 4,
            width: _iconSize / 4,
            decoration: BoxDecoration(
              color: color.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: const Offset(0, -_iconSize / 3),
            child: Icon(
              Icons.location_on,
              size: _iconSize / 1.2,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
