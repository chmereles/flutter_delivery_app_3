import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class RatingStarWidget extends StatelessWidget {
  const RatingStarWidget({
    // this.starCount = 5,
    this.rating = .0,
    this.size = 20,
    // this.onRatingChanged,
    this.color,
    this.cant,
  });

  // final int starCount;
  final double rating;
  final double size;
  final Color? color;
  final int? cant;
  // final RatingChangeCallback? onRatingChanged;

  Widget buildStar(BuildContext context) {
    return Icon(
      Icons.star,
      size: size,
      // color: color ?? Theme.of(context).buttonColor,
      color: color ?? Colors.amber[800],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildStar(context),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size / 2.1,
          ),
        ),
        if (cant != null)
          Text(
            ' ($cant)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size / 2.6,
            ),
          ),
      ],
    );
  }
}
