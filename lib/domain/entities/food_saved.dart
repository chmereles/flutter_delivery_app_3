import 'package:app_delivery_3/domain/entities/food.dart';

class FoodSaved {
  FoodSaved({
    required this.restaurant,
    required this.time,
    required this.food,
  });

  final String restaurant;
  final String time;
  final Food food;
}

final myFoodSavedList = [
  FoodSaved(
    restaurant: 'McDonals',
    time: '15 min',
    food: myFoodList[0],
  ),
  FoodSaved(
    restaurant: 'McDonals',
    time: '15 min',
    food: myFoodList[2],
  ),
  FoodSaved(
    restaurant: 'McDonals',
    time: '15 min',
    food: myFoodList[3],
  ),
];
