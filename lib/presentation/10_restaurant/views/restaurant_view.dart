import 'package:flutter/material.dart';

import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/presentation/widgets/add_cart_button.dart';
import 'package:app_delivery_3/presentation/widgets/counter_widget.dart';
import 'package:app_delivery_3/presentation/widgets/icon_text_widget.dart';
import 'package:app_delivery_3/presentation/widgets/product_list_widget.dart';
import 'package:app_delivery_3/presentation/widgets/rating_widget.dart';

class RestaurantView extends StatelessWidget {
  const RestaurantView({Key? key}) : super(key: key);

  Widget _buildDetails() {
    final cardRadioHeight = SizeConfig.screenHeight * 0.04;
    final leftSep = SizeConfig.screenWidth * 0.05;
    const name = "Mcdonal's";

    const nameStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

    return Container(
      padding: EdgeInsets.only(
        top: cardRadioHeight,
        left: leftSep,
        right: leftSep,
      ),
      // color: Colors.red,
      child: Column(
        children: [
          //
          Container(
            // color: Colors.red,
            height: SizeConfig.screenHeight * 0.1664,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // nombre
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    children: [
                      const Text(name, style: nameStyle),
                      const Spacer(),
                      Icon(
                        Icons.bookmark,
                        color: Colors.amber[800],
                      ),
                    ],
                  ),
                ),

                // types
                const Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: const BuildTypesWidget(
                    types: [r'$$', 'Burger', 'American Food', 'Dash Food'],
                  ),
                ),

                // rating
                Row(
                  children: [
                    RatingStarWidget(
                      size: 29,
                      rating: 4.9,
                    ),
                    SizedBox(width: 10),
                    Text('200+ Ratings'),
                  ],
                ),

                // delivery
                Row(
                  children: [
                    const IconTextWidget(
                      iconData: Icons.monetization_on,
                      text: 'Free delivery',
                      iconColor: Colors.green,
                      iconSize: 24,
                    ),
                    const Spacer(),

                    //
                    const IconTextWidget(
                      iconData: Icons.timer,
                      text: '30 min',
                      iconSize: 24,
                      iconColor: Colors.blue,
                    ),
                    const Spacer(),

                    //
                    SizedBox(
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[50],
                        ),
                        child: Text(
                          'Take away',
                          style: TextStyle(color: Colors.amber),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Container(
              color: Colors.amber,
              height: SizeConfig.screenHeight * 0.062,
            ),
          ),

          //
          const Expanded(child: ProductListWidget()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const image = 'assets/images/restaurant_1.jpg';
    final imageHeight = SizeConfig.screenHeight * 0.34;
    final imageWidth = SizeConfig.screenWidth;
    final cardRadioHeight = SizeConfig.screenHeight * 0.04;
    final cardHeight =
        (SizeConfig.screenHeight - imageHeight) + cardRadioHeight;

    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        fit: StackFit.expand,
        children: [
          //
          Positioned(
            height: imageHeight,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              height: imageHeight,
              width: imageWidth,
            ),
          ),

          //
          Positioned(
            bottom: 0,
            height: cardHeight,
            width: imageWidth,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Theme.of(context).cardColor,
              ),
              child: InkWell(
                  onTap: () => showBottonSheet(context),
                  child: _buildDetails()),
            ),
          ),
        ],
      ),
    );
  }

  void showBottonSheet(BuildContext context) => showModalBottomSheet<Widget>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          decoration: BoxDecoration(
            // color: forDialog ? Color(0xFF737373) : Colors.white,
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: RestaurantProductWidget(),
        ),
      );
}

class BuildTypesWidget extends StatelessWidget {
  const BuildTypesWidget({
    Key? key,
    required this.types,
  }) : super(key: key);

  final List<String> types;
  @override
  Widget build(BuildContext context) {
    return Row(
      // children: [for (var type in types) Text('$type - ')],
      children: [
        for (var i = 0; i < types.length; i++)
          if (i != types.length - 1)
            Row(
              children: [
                i == 0 ? Text('${types[i]} ') : Text(' ${types[i]} '),
                Icon(
                  Icons.fiber_manual_record,
                  size: 8,
                ),
              ],
            )
          else
            Text('${types[i]}')
      ],
    );
  }
}

class RestaurantProductWidget extends StatefulWidget {
  const RestaurantProductWidget({Key? key}) : super(key: key);

  @override
  _RestaurantProductWidgetState createState() =>
      _RestaurantProductWidgetState();
}

class _RestaurantProductWidgetState extends State<RestaurantProductWidget> {
  final _maxSliderValue = 4.0;

  late double _sliderValue;
  late double _minValue;
  late double _maxValue;
  late double _maxHeight;
  late double _minheight;
  late double _threshold;

  @override
  void initState() {
    _minValue = _maxSliderValue * 1 / 4;
    _maxValue = _maxSliderValue * 3 / 4;
    _threshold = _maxSliderValue * 0.5;
    _maxHeight = SizeConfig.screenHeight * 0.85;
    _minheight = SizeConfig.screenHeight * 0.5;
    _sliderValue = _minValue;

    super.initState();
  }

  void _updateValue(double value) {
    _sliderValue = value;

    if (_sliderValue <= _threshold) {
      _sliderValue = _minValue;
    } else {
      _sliderValue = _maxValue;
    }

    setState(() {});
  }

  Widget _buildSlider() {
    final width = SizeConfig.screenWidth * 0.6;
    const horizontalPadding = 24.0;
    const labelStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 11,
    );
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            const Text('Size'),
            const Spacer(),
            Container(
              width: width,
              height: 30,
              color: Colors.amber,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    trackHeight: 2,
                    activeTrackColor: Colors.grey,
                    inactiveTrackColor: Colors.grey,
                    trackShape: const RectangularSliderTrackShape(),
                    thumbColor: Theme.of(context).accentColor,
                    // overlayColor: Colors.red.withAlpha(32),
                    overlayColor: Theme.of(context).accentColor.withAlpha(32),
                    valueIndicatorColor: Colors.black),
                child: Slider(
                  max: _maxSliderValue,
                  divisions: 4,
                  value: _sliderValue,
                  onChanged: _updateValue,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            // Text('data'),
            const SizedBox.shrink(),
            const Spacer(),
            SizedBox(
              // color: Colors.blue,
              width: width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding),
                    child: Row(
                      children: [
                        // const Expanded(
                        //   child: SizedBox.shrink(),
                        // ),
                        const Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              'Burger Only',
                              style: labelStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              'Meel',
                              style: labelStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        // const Expanded(
                        //   child: SizedBox.shrink(),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (details) {
        // print(details);
        if (_sliderValue == _minValue) {
          _updateValue(_maxValue);
        } else {
          _updateValue(_minValue);
        }
      },
      child: Container(
        height: _sliderValue == _minValue ? _minheight : _maxHeight,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              _sliderValue == _maxValue ? Icons.expand_more : Icons.expand_less,
              size: 30,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/retaurants/restaurant_product_2.png',
                  height: 100,
                ),
                const SizedBox(width: 10),
                Column(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('hola munod'),
                    const Text('hola munod'),
                    const Text('hola munod'),
                  ],
                ),
              ],
            ),
            //
            const Divider(),
            //
            Row(
              children: [
                const Text('Quantity'),
                const Spacer(),
                const CounterWidget(),
              ],
            ),
            //
            _buildSlider(),

            //
            if (_sliderValue == _maxValue)
              BuildMeelList(child: SizedBox.shrink()),
            if (_sliderValue == _maxValue)
              BuildMeelList(child: SizedBox.shrink()),

            const SizedBox(height: 20),
            //
            const AddCartButton(
              total: 15,
              // height: SizeConfig.screenHeight * 0.0678,
            ),
          ],
        ),
      ),
    );
  }
}

class BuildMeelList extends StatelessWidget {
  const BuildMeelList({Key? key, required this.child}) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    // final listHeight = SizeConfig.screenHeight * 0.08;
    final listHeight = SizeConfig.screenWidth * 0.16;
    final size = Size(listHeight, listHeight);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('adsfadsf'),
        SizedBox(
          height: listHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: BuildSidesCard(size: size, index: index + 1),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class BuildSidesCard extends StatelessWidget {
  const BuildSidesCard({
    Key? key,
    required this.size,
    required this.index,
  }) : super(key: key);

  final int index;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Card(
        elevation: 5,
        child: Image.asset(
          'assets/retaurants/side_$index.jpg',
          fit: BoxFit.contain,
          height: size.height * 0.5,
          width: size.width * 0.5,
        ),
      ),
    );
  }
}
