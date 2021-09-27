import 'package:flutter/material.dart';

class CustomButtonSheet extends StatelessWidget {
  const CustomButtonSheet({
    Key? key,
    this.height = 300,
    this.child,
  }) : super(key: key);

  final double? height;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).cardColor;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, -20),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
            ),
          ),
          Container(
            color: color,
            height: height,
            child: child,
          )
        ],
      ),
    );
  }
}
