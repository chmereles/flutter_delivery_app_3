import 'package:flutter/material.dart';

const _iconSize = 20.0;
const _textStyle = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.bold,
);

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    Key? key,
    required this.width,
    required this.address,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.showExpand = true,
  }) : super(key: key);

  final double width;
  final String address;
  final bool showExpand;
  final MainAxisAlignment mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        const Icon(
          Icons.pin_drop_outlined,
          size: _iconSize,
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: width * 0.7,
          child: Text(
            address,
            style: _textStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (showExpand)
          const Icon(
            Icons.expand_more_outlined,
            size: _iconSize,
          ),
      ],
    );
  }
}
