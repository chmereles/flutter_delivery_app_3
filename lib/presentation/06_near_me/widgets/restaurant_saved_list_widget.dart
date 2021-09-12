import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/domain/entities/restaurant.dart';
import 'package:app_delivery_3/presentation/widgets/free_delivery.dart';
import 'package:app_delivery_3/presentation/widgets/icon_text_widget.dart';
import 'package:app_delivery_3/presentation/widgets/image_border_radius.dart';
import 'package:app_delivery_3/presentation/widgets/rating_widget.dart';
import 'package:app_delivery_3/presentation/widgets/types_widget.dart';
import 'package:flutter/material.dart';

final _cardHeight = SizeConfig.screenHeight * 0.13;

class RestaurantNearList extends StatelessWidget {
  const RestaurantNearList({
    Key? key,
    required this.restaurantList,
  }) : super(key: key);

  final List<Restaurant> restaurantList;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: restaurantList.length,
      itemBuilder: (context, index) {
        return _RestaurnatWidget(restaurantSaved: restaurantList[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class _RestaurnatWidget extends StatelessWidget {
  const _RestaurnatWidget({
    Key? key,
    required this.restaurantSaved,
  }) : super(key: key);

  final Restaurant restaurantSaved;
  @override
  Widget build(BuildContext context) {
    final restaurantName = restaurantSaved.name;
    final restaurantImage = restaurantSaved.image;
    final freeDelivery = restaurantSaved.freeDelivery;
    final retaurantRating = restaurantSaved.rating;
    final foodList = restaurantSaved.foodList;

    final time = restaurantSaved.time;
    final imageHeight = _cardHeight * 0.9;

    const restaurantNameStyle = TextStyle(
      fontWeight: FontWeight.bold,
    );
    // const typesStyle = TextStyle(
    //   fontSize: 12,
    // );
    // final priceStyle = TextStyle(
    //   color: Theme.of(context).accentColor,
    // );

    //
    return SizedBox(
      height: _cardHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          children: [
            // image
            ImageBorderRadius(image: restaurantImage, imageHeight: imageHeight),
            const SizedBox(width: 10),
            //
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // restaurant
                  Text(
                    restaurantName,
                    style: restaurantNameStyle,
                  ),

                  // types
                  TypesWidget(
                      types: foodList, iconData: Icons.local_dining_outlined),

                  // rating, time and price
                  Row(
                    children: [
                      RatingStarWidget(
                        rating: retaurantRating,
                      ),
                      const Spacer(),
                      IconTextWidget(
                        iconData: Icons.local_shipping_outlined,
                        text: time,
                      ),
                      const Spacer(),
                      FreeDelivery(freeDelivery: freeDelivery),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
