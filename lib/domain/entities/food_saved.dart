import 'package:app_delivery_3/domain/entities/food.dart';

class FoodSaved {
  FoodSaved({
    required this.restaurant,
    required this.deliverTime,
    required this.food,
  });

  final String restaurant;
  final String deliverTime;
  final Food food;
}

final myFoodSavedList = [
  FoodSaved(
    restaurant: 'McDonals',
    deliverTime: '15 min',
    food: myFoodList[0],
  ),
  FoodSaved(
    restaurant: 'McDonals',
    deliverTime: '15 min',
    food: myFoodList[2],
  ),
  FoodSaved(
    restaurant: 'McDonals',
    deliverTime: '15 min',
    food: myFoodList[3],
  ),
];
