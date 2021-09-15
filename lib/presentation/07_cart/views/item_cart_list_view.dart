import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/domain/entities/food.dart';
import 'package:app_delivery_3/presentation/widgets/counters/counter_widget.dart';
import 'package:app_delivery_3/presentation/widgets/image_border_radius.dart';
import 'package:flutter/material.dart';

final _cardHeight = SizeConfig.screenHeight * 0.13;

class ItemCartListView extends StatelessWidget {
  const ItemCartListView({
    Key? key,
    required this.foodList,
  }) : super(key: key);

  final List<Food> foodList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: foodList.length,
      itemBuilder: (context, index) {
        return _FoodWidget(food: foodList[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class _FoodWidget extends StatelessWidget {
  const _FoodWidget({Key? key, required this.food}) : super(key: key);

  final Food food;
  @override
  Widget build(BuildContext context) {
    final descriptino = food.name;
    final image = food.image;
    final price = food.price;
    final cant = 10;

    final imageHeight = _cardHeight * 0.9;

    const nameStyle = TextStyle(
      fontWeight: FontWeight.bold,
    );

    const priceStyle = TextStyle(
      fontWeight: FontWeight.bold,
    );
    //
    return SizedBox(
      height: _cardHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          children: [
            // image
            ImageBorderRadius(image: image, imageHeight: imageHeight),
            const SizedBox(width: 10),
            //
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // restaurant
                  Text(
                    descriptino,
                    style: nameStyle,
                  ),
                  Row(
                    children: [
                      Text(
                        price.toStringAsFixed(2),
                        style: priceStyle,
                      ),
                      CounterWidget(),
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
