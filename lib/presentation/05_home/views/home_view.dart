import 'package:app_delivery_3/presentation/widgets/restaurant_item_widget.dart';
import 'package:flutter/material.dart';

import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/presentation/widgets/my_tabbar.dart';
import 'package:app_delivery_3/presentation/widgets/rating_widget.dart';
import 'package:app_delivery_3/presentation/widgets/restaurant_list_widget.dart';

const leftPadding = 12.0;

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataTabs = [
      [
        Text('Recents'),
        Text('Favorite'),
        Text('Rating'),
        Text('Popular'),
        Text('Trending'),
      ],
      [
        SizedBox(
          // color: Colors.red,
          height: cardHeight * 3,
          child: const RestaurantsListWidget(),
        ),
        Text('favorite data'),
        Text('rating data'),
        Text('popular data'),
        Text('trending data'),
      ]
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: SizeConfig.screenHeight * 0.3,
              color: Theme.of(context).primaryColor,
            ),

            const FavoriteWidet(),
            const SizedBox(height: 15),

            SizedBox(
              height: cardHeight * 3,
              child: MyTabBar(
                myTabs: dataTabs,
              ),
            ),
            const SizedBox(height: 15),

            // SizedBox(
            //   // color: Colors.red,
            //   height: cardHeight * 3,
            //   child: const RestaurantsWidget(),
            // ),

            Container(
              height: cardAgainHeight + 45,
              // color: Colors.amber,
              child: const OrderAgainWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteWidet extends StatelessWidget {
  const FavoriteWidet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const favStyle = TextStyle(fontWeight: FontWeight.bold);

    final cardSize = Size(
      SizeConfig.screenHeight * 0.32,
      SizeConfig.screenHeight * 0.26,
    );

    return Container(
      height: SizeConfig.screenHeight * 0.27,
      // padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: leftPadding - leftPadding,
              vertical: leftPadding - leftPadding,
            ),
            child: Text('Favorite', style: favStyle),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return FavoriteItemWidget(
                  size: cardSize,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteItemWidget extends StatelessWidget {
  const FavoriteItemWidget({Key? key, required this.size}) : super(key: key);

  final Size size;
  @override
  Widget build(BuildContext context) {
    final image = 'assets/retaurants/burger_king.png';
    final restaurant = 'Burger King';
    final types = ['Burger', 'American food'];
    final rating = 4.9;
    final ratingVotes = 150;
    final distance = '150m';
    final time = '30';

    const restaurantStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    const typesStyle = TextStyle(fontSize: 10);

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Stack(
              children: [
                // top image
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    height: size.height * 0.6,
                    width: size.width,
                  ),
                ),

                // favorite
                const Align(
                  alignment: Alignment(0.9, -0.9),
                  child: Icon(
                    Icons.bookmark_border_outlined,
                    color: Colors.red,
                  ),
                ),

                // detalles, nombre, rating
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: size.height * 0.32,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            restaurant,
                            style: restaurantStyle,
                          ),
                        ),
                        // ),

                        // food types
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (var type in types)
                                Text(
                                  '$type   ',
                                  style: typesStyle,
                                ),
                            ],
                          ),
                          // ),
                        ),

                        const RatingStarWidget(
                          rating: 4.9,
                          cant: 150,
                        ),
                      ],
                    ),
                  ),
                ),

                // nombre
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildType(Icons.location_on_outlined, '150m'),
                      SizedBox(width: 5),
                      _buildType(Icons.schedule_outlined, '30m'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildType(IconData iconData, String text) {
    final bakcgroundColor = Colors.red[100];
    final textColor = Colors.red[400];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: bakcgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 20,
      child: Row(
        children: [
          Icon(
            iconData,
            size: 16,
            color: textColor,
          ),
          Text(
            ' $text',
            style: TextStyle(
              fontSize: 10,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderAgainWidget extends StatelessWidget {
  const OrderAgainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontWeight: FontWeight.bold);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(leftPadding),
          child: const Text('Order again', style: textStyle),
        ),
        SizedBox(
          height: cardAgainHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return OrderAgainItem();
            },
          ),
        ),
      ],
    );
  }
}

class OrderAgainItem extends StatelessWidget {
  const OrderAgainItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardSize = Size(cardAgainWidht, cardAgainHeight);

    return BuildItemWidget(
      size: cardSize,
    );
  }
}

class BuildItemWidget extends StatelessWidget {
  const BuildItemWidget({Key? key, required this.size}) : super(key: key);

  final Size size;
  @override
  Widget build(BuildContext context) {
    const image = 'assets/retaurants/burger_king.png';
    const restaurant = 'Burger King';
    const types = ['Burger', 'American food'];
    const rating = 4.9;
    const ratingVotes = 150;
    const distance = '150m';
    const price = 5.5;
    const name = 'Burger Meel';

    const nameStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    const retaurantStyle = TextStyle(fontSize: 10);

    final heightImage = size.height * 0.55;
    final heightDetails = size.height * 0.33;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Card(
        // color: Colors.amber,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Stack(
            children: [
              // top image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  height: heightImage,
                  width: size.width,
                ),
              ),

              // favorite
              const Align(
                alignment: Alignment(0.9, -0.9),
                child: Icon(
                  Icons.bookmark_border_outlined,
                  color: Colors.red,
                ),
              ),

              // detalles, nombre, rating
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  height: heightDetails,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: nameStyle,
                        ),
                      ),
                      // ),

                      // food types
                      Expanded(
                        child: Text(
                          restaurant,
                          style: retaurantStyle,
                        ),
                      ),

                      Expanded(
                        child: Text(
                          '$price',
                          style: retaurantStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // nombre
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  iconSize: 20,
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildType(IconData iconData, String text) {
    final bakcgroundColor = Colors.red[100];
    final textColor = Colors.red[400];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: bakcgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 20,
      child: Row(
        children: [
          Icon(
            iconData,
            size: 16,
            color: textColor,
          ),
          Text(
            ' $text',
            style: TextStyle(
              fontSize: 10,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
