import 'package:app_delivery_3/presentation/my_address/widgets/circle_button_widget.dart';
import 'package:flutter/material.dart';

class BuildGpsFixed extends StatelessWidget {
  const BuildGpsFixed({
    Key? key,
    this.size = 60,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;
  final double size;
  @override
  Widget build(BuildContext context) {
    return BuildCircleButton(
      color1: Theme.of(context).colorScheme.primary,
      color2: Colors.white,
      iconData: Icons.gps_fixed_outlined,
      onTap: onTap,
      size: size,
    );
  }
}
