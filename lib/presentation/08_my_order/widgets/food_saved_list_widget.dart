import 'package:flutter/material.dart';
import 'package:app_delivery_3/presentation/widgets/icon_text_widget.dart';
import 'package:app_delivery_3/presentation/widgets/image_border_radius.dart';
import 'package:app_delivery_3/presentation/widgets/rating_widget.dart';
import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/domain/entities/food_saved.dart';

final _cardHeight = SizeConfig.screenHeight * 0.13;

class FoodSavedList extends StatelessWidget {
  const FoodSavedList({
    Key? key,
    required this.foodList,
  }) : super(key: key);

  final List<FoodSaved> foodList;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: foodList.length,
      itemBuilder: (context, index) {
        return _FoodWidget(foodSaved: foodList[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class _FoodWidget extends StatelessWidget {
  const _FoodWidget({
    Key? key,
    required this.foodSaved,
  }) : super(key: key);

  final FoodSaved foodSaved;
  @override
  Widget build(BuildContext context) {
    final foodName = foodSaved.food.name;
    final foodImage = foodSaved.food.image;
    final foodPrice = foodSaved.food.price;
    final foodRating = foodSaved.food.rating;
    final restaurant = foodSaved.restaurant;
    final time = foodSaved.deliverTime;
    final imageHeight = _cardHeight * 0.9;

    const foodNameStyle = TextStyle(
      fontWeight: FontWeight.bold,
    );
    const restaurantStyle = TextStyle(
      fontSize: 12,
    );
    final priceStyle = TextStyle(
      color: Theme.of(context).colorScheme.secondary,
    );

    //
    return SizedBox(
      height: _cardHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          children: [
            // image
            ImageBorderRadius(image: foodImage, imageHeight: imageHeight),
            const SizedBox(width: 10),
            //
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // food name
                  Text(
                    foodName,
                    style: foodNameStyle,
                  ),
                  // restaurant
                  Text(
                    restaurant,
                    style: restaurantStyle,
                  ),
                  // rating, time and price
                  Row(
                    children: [
                      RatingStarWidget(
                        rating: foodRating,
                      ),
                      const Spacer(),
                      IconTextWidget(
                        iconData: Icons.local_shipping_outlined,
                        text: time,
                      ),
                      const Spacer(),
                      Text(
                        '\$ $foodPrice',
                        style: priceStyle,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
