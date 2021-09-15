import 'package:app_delivery_3/presentation/widgets/icon_text_widget.dart';
import 'package:flutter/material.dart';

import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/presentation/widgets/rating_widget.dart';

final cardHeight = SizeConfig.screenHeight * 0.155;
final cardAgainHeight = cardHeight * 1.62;
final cardAgainWidht = cardAgainHeight * 0.9;

class RestaurantItemWidget extends StatelessWidget {
  const RestaurantItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const image = 'assets/retaurants/burger_king_logo.png';
    const restaurant = 'Burger King';
    const typeColor = Colors.grey;
    final cardWidth = SizeConfig.screenWidth * 0.8;
    final imageHeight = cardHeight * 0.9;
    const restaurantStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    const typesStyle = TextStyle(
      fontSize: 12,
      color: typeColor,
    );

    //
    return SizedBox(
      height: cardHeight,
      //TODO: cotnroar aqui
      width: cardWidth,

      //
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Row(
            children: [
              // image
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  height: imageHeight,
                  width: imageHeight / 1.2,
                ),
              ),

              const SizedBox(width: 10),
              //
              Expanded(
                child: Container(
                  // color: Colors.amber,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // nombre
                      Row(
                        children: [
                          Text(
                            restaurant,
                            style: restaurantStyle,
                          ),
                          Spacer(),
                          Icon(
                            Icons.bookmark_border_outlined,
                            color: Colors.red,
                          ),
                        ],
                      ),

                      // type
                      Row(
                        children: [
                          const Text(
                            'Burger',
                            style: typesStyle,
                          ),
                          const SizedBox(width: 10),
                          const IconTextWidget(
                            iconData: Icons.location_on_outlined,
                            text: '2.1 Km',
                            fontSize: 12,
                            color: typeColor,
                          ),
                        ],
                      ),

                      //
                      Row(
                        children: [
                          const RatingStarWidget(rating: 5.0, size: 24),
                          const Spacer(),
                          const IconTextWidget(
                            iconData: Icons.schedule_outlined,
                            text: '10 min',
                            fontSize: 12,
                            // color: typeColor,
                          ),
                          const Spacer(),
                          IconTextWidget(
                            iconData: Icons.phone_forwarded_outlined,
                            text: 'Contact',
                            fontSize: 12,
                            iconColor: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
