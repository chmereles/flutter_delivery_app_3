import 'package:flutter/material.dart';

import 'package:app_delivery_3/l10n/l10n.dart';
import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/domain/entities/food_saved.dart';
import 'package:app_delivery_3/domain/entities/restaurant_saved.dart';
import 'package:app_delivery_3/presentation/08_my_order/widgets/food_saved_list_widget.dart';
import 'package:app_delivery_3/presentation/08_my_order/widgets/restaurant_saved_list_widget.dart';
import 'package:app_delivery_3/presentation/widgets/build_app_bar.dart';
import 'package:app_delivery_3/presentation/widgets/custom_button.dart';

class MyOrderView extends StatelessWidget {
  const MyOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _BuildBody();
  }
}

class _BuildBody extends StatefulWidget {
  const _BuildBody({Key? key}) : super(key: key);

  @override
  _BuildBodyState createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  bool foodsButtonSelected = true;

  void updateSelectedButton(bool food) {
    if (foodsButtonSelected != food) {
      setState(() {
        foodsButtonSelected = food;
      });
    }
  }

  void foodPressed() {
    updateSelectedButton(true);
  }

  void restaurantPressed() {
    updateSelectedButton(false);
  }

  Widget _buildButtons(BuildContext context, String foods, String restaurant) {
    final buttonHeight = SizeConfig.screenHeight * 0.055;
    final buttonWidth = SizeConfig.screenWidth * 0.393;
    final disabledColor = Theme.of(context).disabledColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          height: buttonHeight,
          width: buttonWidth,
          onPressed: foodPressed,
          color: !foodsButtonSelected ? disabledColor : null,
          child: Text(foods),
        ),
        CustomButton(
          height: buttonHeight,
          width: buttonWidth,
          onPressed: restaurantPressed,
          color: foodsButtonSelected ? disabledColor : null,
          child: Text(restaurant),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: BuildAppBar(title: Text(l10n.mySaved)),
      body: Padding(
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
        child: Column(
          children: [
            _buildButtons(context, l10n.mySavedFoods, l10n.mySavedRestaurant),
            const SizedBox(height: 12),
            Expanded(
              child: foodsButtonSelected
                  ? FoodSavedList(foodList: myFoodSavedList)
                  : RestaurantSavedList(restaurantList: myRestaurantSavedList),
            )
          ],
        ),
      ),
    );
  }
}
