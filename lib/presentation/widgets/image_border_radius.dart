import 'package:flutter/material.dart';

class ImageBorderRadius extends StatelessWidget {
  const ImageBorderRadius({
    Key? key,
    required this.image,
    required this.imageHeight,
    this.imageWidth,
  }) : super(key: key);

  final String image;
  final double imageHeight;
  final double? imageWidth;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
        height: imageHeight,
        width: imageWidth ?? imageHeight / 1.2,
      ),
    );
  }
}
