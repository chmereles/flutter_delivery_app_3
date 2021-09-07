import 'package:app_delivery_3/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:app_delivery_3/l10n/l10n.dart';

import 'package:app_delivery_3/presentation/widgets/custom_button.dart';

final _buttonHeight = SizeConfig.screenHeight * 0.0678;

class AddCartButton extends StatelessWidget {
  const AddCartButton({
    Key? key,
    required this.total,
  }) : super(key: key);

  final double total;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return CustomButton(
      height: _buttonHeight,
      onPressed: () {},
      child: Row(
        children: [
          Text(l10n.addToCart),
          const Spacer(),
          Text('\$${total.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}
