import 'package:app_delivery_3/config/app_constants.dart';
import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(double rating);

class RatingStarWidget extends StatelessWidget {
  const RatingStarWidget({
    Key? key,
    // this.starCount = 5,
    this.rating = .0,
    this.size = AppConstants.defaultIconSize,
    // this.onRatingChanged,
    this.color,
    this.cant,
  }) : super(key: key);

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
