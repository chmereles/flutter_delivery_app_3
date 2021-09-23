import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/domain/entities/food.dart';
import 'package:app_delivery_3/presentation/06_near_me/near_me_view.dart';
import 'package:app_delivery_3/presentation/07_cart/views/item_cart_list_view.dart';
import 'package:app_delivery_3/presentation/widgets/build_app_bar.dart';
import 'package:app_delivery_3/presentation/widgets/custom_button.dart';
import 'package:app_delivery_3/presentation/widgets/image_border_radius.dart';
import 'package:flutter/material.dart';
import 'package:app_delivery_3/l10n/l10n.dart';

final _cardHeight = SizeConfig.screenHeight * 0.12;
final _promoHeight = SizeConfig.screenHeight * 0.08;
final _detailsHeight = SizeConfig.screenHeight * 0.15;
final _totalHeight = SizeConfig.screenHeight * 0.09;
final _delivryToHeight = SizeConfig.screenHeight * 0.12;

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _BuildBody();
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({
    Key? key,
  }) : super(key: key);

  Widget _buildPromoCode(BuildContext context) {
    return SizedBox(
      height: _promoHeight,
      child: Row(
        children: [
          Icon(
            Icons.local_activity,
            color: Theme.of(context).colorScheme.secondary,
            size: 35,
          ),
          const SizedBox(width: 5),
          const Text('Add promo code'),
          const Spacer(),
          const Icon(Icons.navigate_next),
        ],
      ),
    );
  }

  Widget _buildTotalDetails(BuildContext context) {
    return SizedBox(
      height: _detailsHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Text('Item total'),
              Spacer(),
              Text('\$50'),
            ],
          ),
          Row(
            children: [
              Text('Discount'),
              Spacer(),
              Text('\$10'),
            ],
          ),
          Row(
            children: [
              Text('Delivery'),
              Spacer(),
              Text('Free'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotal(BuildContext context) {
    const textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
    );
    return SizedBox(
      height: _totalHeight,
      child: Row(
        children: [
          Text('Total', style: textStyle),
          Spacer(),
          Text('\$70', style: textStyle),
        ],
      ),
    );
  }

  Widget _buildDeliveryTo(BuildContext context) {
    final imageHeight = 100.0;
    final restaurantImage = 'assets/images/delivery.png';
    final deliveryTo = 'Home';

    const textSyle = TextStyle(fontWeight: FontWeight.bold);
    final changeSyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.secondary,
    );

    return SizedBox(
      height: _delivryToHeight,
      child: Row(
        children: [
          // image
          ImageBorderRadius(image: restaurantImage, imageHeight: imageHeight),
          const SizedBox(width: 10),
          //
          Expanded(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // restaurant
                Row(
                  children: [
                    Text(
                      'Deliver to: $deliveryTo',
                      style: textSyle,
                    ),
                    Spacer(),
                    Text(
                      'Change',
                      style: changeSyle,
                    ),
                  ],
                ),

                AddressWidget(width: 200, address: 'address'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckuotButton(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return CustomButton(
      onPressed: () {},
      child: Text('Checkuot '),
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final List<Food> foodList = [
      myFoodList[0],
      myFoodList[2],
      myFoodList[3],
    ];

    return Scaffold(
      appBar: BuildAppBar(title: Text(l10n.myCart)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: _cardHeight * 2,
                child: ItemCartListView(
                  foodList: foodList,
                ),
              ),
              const Divider(),
              //
              _buildPromoCode(context),
              const Divider(),
              //
              _buildTotalDetails(context),
              const Divider(),
              //
              _buildTotal(context),
              const Divider(),
              //
              _buildDeliveryTo(context),
              //
              _buildCheckuotButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
