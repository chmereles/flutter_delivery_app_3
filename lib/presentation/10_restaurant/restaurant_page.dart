import 'package:app_delivery_3/presentation/10_restaurant/views/restaurant_view.dart';
import 'package:flutter/material.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  static String id = 'restaurant-page';
  @override
  Widget build(BuildContext context) {
    return const RestaurantView();
  }
}
