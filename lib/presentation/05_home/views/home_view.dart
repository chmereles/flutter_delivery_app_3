import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/presentation/widgets/build_app_bar.dart';
import 'package:app_delivery_3/presentation/widgets/my_tabbar.dart';
import 'package:app_delivery_3/presentation/widgets/rating_widget.dart';
import 'package:app_delivery_3/presentation/widgets/restaurant_item_widget.dart';
import 'package:app_delivery_3/presentation/widgets/restaurant_list_widget.dart';
import 'package:flutter/material.dart';

const leftPadding = 12.0;

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  Widget _buildDelivered(BuildContext context) {
    const iconSize = 18.0;
    const textStyle = TextStyle(fontSize: 14);
    final color = Theme.of(context).colorScheme.secondary;

    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.pin_drop_outlined,
          size: iconSize,
        ),
        const Text(
          'Delivery to',
          style: textStyle,
        ),
        const SizedBox(width: 10),
        Text(
          'HOME',
          style: textStyle.copyWith(color: color),
        ),
        Icon(
          Icons.expand_more_outlined,
          size: iconSize,
          color: color,
        ),
      ],
    );
  }

  Widget _buildNotification(BuildContext context) {
    const notificationSize = 15.0;
    const notification = '2';
    const textStyle = TextStyle(fontSize: 11, color: Colors.white);
    const splashRadius = 25.0;
    final notificationColor = Theme.of(context).colorScheme.secondary;

    void _onPressed() {
      print('button pressed');
    }

    return Container(
      // color: Colors.red,
      child: Stack(
        children: [
          IconButton(
            splashRadius: splashRadius,
            onPressed: _onPressed,
            icon: Stack(
              children: [
                const Align(
                  child: Icon(Icons.notifications_active_outlined),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      height: notificationSize,
                      width: notificationSize,
                      decoration: BoxDecoration(
                        // color: Colors.black,
                        color: notificationColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                      ),
                      child: const Center(
                        child: Text(notification, style: textStyle),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataTabs = [
      [
        const Text('Recents'),
        const Text('Favorite'),
        const Text('Rating'),
        const Text('Popular'),
        const Text('Trending'),
      ],
      [
        SizedBox(
          // color: Colors.red,
          height: cardHeight * 3,
          child: const RestaurantsListWidget(),
        ),
        const Text('favorite data'),
        const Text('rating data'),
        const Text('popular data'),
        const Text('trending data'),
      ]
    ];
    return Scaffold(
      appBar: AppBar(
        // foregroundColor: Colors.white,
        iconTheme: IconThemeData().copyWith(color: Colors.white),
        title: _buildDelivered(context),
        actions: [_buildNotification(context)],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: SizeConfig.screenHeight * 0.3,
              color: Theme.of(context).colorScheme.primary,
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

    return SizedBox(
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
    const image = 'assets/retaurants/burger_king.png';
    const restaurant = 'Burger King';
    final types = ['Burger', 'American food'];
    // const rating = 4.9;
    // const ratingVotes = 150;
    // const distance = '150m';
    // const time = '30';

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
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Stack(
              children: [
                // top image
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                        const Expanded(
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
                      const SizedBox(width: 5),
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
        borderRadius: const BorderRadius.all(Radius.circular(20)),
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
        const Padding(
          padding: EdgeInsets.all(leftPadding),
          child: Text('Order again', style: textStyle),
        ),
        SizedBox(
          height: cardAgainHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return const OrderAgainItem();
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
    // const types = ['Burger', 'American food'];
    // const rating = 4.9;
    // const ratingVotes = 150;
    // const distance = '150m';
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Stack(
            children: [
              // top image
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                      const Expanded(
                        child: Text(
                          name,
                          style: nameStyle,
                        ),
                      ),
                      // ),

                      // food types
                      const Expanded(
                        child: Text(
                          restaurant,
                          style: retaurantStyle,
                        ),
                      ),

                      const Expanded(
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
                  icon: const Icon(
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
        borderRadius: const BorderRadius.all(Radius.circular(20)),
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
