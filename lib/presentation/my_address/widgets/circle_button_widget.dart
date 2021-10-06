import 'package:flutter/material.dart';

class BuildCircleButton extends StatelessWidget {
  const BuildCircleButton({
    Key? key,
    required this.color1,
    required this.color2,
    required this.iconData,
    this.onTap,
    this.size = 60,
  }) : super(key: key);

  final Color color1;
  final Color color2;
  final IconData iconData;
  final double size;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: size,
        width: size,
        child: Card(
          color: color1,
          shape: const CircleBorder(),
          child: Icon(
            iconData,
            color: color2,
            size: size / 1.8,
          ),
        ),
      ),
    );
  }
}
