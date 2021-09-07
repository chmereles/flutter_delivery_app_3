import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.bold,
    this.height,
    this.color,
    this.image,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final bool? bold;
  final double? height;
  final Color? color;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Stack(
          children: [
            if (image != null)
              Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
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
