import 'package:flutter/material.dart';

import 'package:app_delivery_3/l10n/l10n.dart';
import 'package:app_delivery_3/presentation/widgets/icon_text_widget.dart';

class FreeDelivery extends StatelessWidget {
  const FreeDelivery({Key? key, required this.freeDelivery}) : super(key: key);

  final bool freeDelivery;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return IconTextWidget(
      iconData: Icons.monetization_on,
      text: freeDelivery ? l10n.freeDelivery : '',
      iconColor: freeDelivery ? Colors.green : Theme.of(context).disabledColor,
      iconSize: 24,
    );
  }
}
