import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.bold,
    this.height,
    this.width,
    this.color,
    this.image,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final bool? bold;
  final double? height;
  final double? width;
  final Color? color;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 300, height: height),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          // maximumSize: Size(width ?? double.infinity, height ?? 50),
        ),
        child: Stack(
          children: [
            if (image != null)
              Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: Image.asset(image!),
                ),
              ),
            Align(child: child),
          ],
        ),
      ),
    );
  }
}
