import 'package:flutter/material.dart';

import 'package:app_delivery_3/presentation/widgets/restaurant_item_widget.dart';

class RestaurantsListWidget extends StatelessWidget {
  const RestaurantsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return RestaurantItemWidget();
        },
      ),
    );
  }
}
