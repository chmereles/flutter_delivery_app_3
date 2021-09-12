import 'package:flutter/material.dart';

import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/presentation/widgets/counter_widget.dart';

final cardHeight = SizeConfig.screenHeight * 0.155;

class FoodCardWidget extends StatelessWidget {
  const FoodCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const image = 'assets/retaurants/burger_king_logo.png';
    const restaurant = 'Burger King';
    const description =
        'Sandwich features two savory flame-grilled beef patties';
    const typeColor = Colors.grey;

    final imageHeight = cardHeight * 0.9;
    const restaurantStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    final priceStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: Theme.of(context).colorScheme.secondary,
    );
    const typesStyle = TextStyle(
      fontSize: 12,
      color: typeColor,
      height: 1.2,
    );

    //
    return SizedBox(
      height: cardHeight,

      //
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Row(
            children: [
              // image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
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
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // nombre
                      Text(
                        restaurant,
                        style: restaurantStyle,
                      ),

                      // type
                      const Text(
                        description,
                        style: typesStyle,
                      ),

                      //
                      Row(
                        children: [
                          Text(
                            r'$ 15.00',
                            style: priceStyle,
                          ),
                          const Spacer(),
                          const CounterWidget()
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
