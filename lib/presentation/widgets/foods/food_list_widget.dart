import 'package:app_delivery_3/presentation/widgets/foods/food_card_widget.dart';
import 'package:flutter/material.dart';

class FoodListWidget extends StatelessWidget {
  const FoodListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return const FoodCardWidget();
      },
    );
  }
}
