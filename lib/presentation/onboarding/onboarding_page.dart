import 'package:flutter/material.dart';

import 'package:app_delivery_3/presentation/onboarding/views/onboarding_view.dart';
import 'package:app_delivery_3/config/size_config.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  static const String id = 'onboarding-page';

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int viewSelectedIndex = 0;
  PageController controller = PageController();

  void _nextScreen() {
    setState(() {
      viewSelectedIndex = viewSelectedIndex + 1;
      controller.jumpToPage(viewSelectedIndex);
    });
  }

  void _skip() {
    setState(() {
      viewSelectedIndex = 0;
      controller.jumpToPage(viewSelectedIndex);
    });
  }

  Widget _buildIndicator(BuildContext context) {
    return SizedBox(
      // decoration: BoxDecoration(border: Border.all()),
      height: SizeConfig.screenHeight * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIndicatorItem(context, 0),
          _buildIndicatorItem(context, 1),
          _buildIndicatorItem(context, 2),
        ],
      ),
    );
  }

  Widget _buildIndicatorItem(BuildContext context, int index) {
    final active = index == viewSelectedIndex;

    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        decoration: BoxDecoration(
          color: active ? Theme.of(context).accentColor : Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
        height: 8,
        width: 15,
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return SizedBox(
      // decoration: BoxDecoration(border: Border.all()),
      // padding: EdgeInsets.only(top: 15),

      height: SizeConfig.screenHeight * 0.08,
      width: SizeConfig.screenWidth * 0.6,
      child: viewSelectedIndex < 2
          ? Row(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(onPressed: _skip, text: 'SKIP'),
                _buildButton(onPressed: _nextScreen, text: 'NEXT'),
              ],
            )
          // height: SizeConfig.screenHeight * 0.18,

          : SizedBox(
              width: SizeConfig.screenWidth * 0.45,
              child: ElevatedButton(
                onPressed: _skip,
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor),
                child: const Text('Get Started'),
              ),
            ),
    );
  }

  InkResponse _buildButton(
      {required VoidCallback onPressed, required String text}) {
    return InkResponse(
      radius: 35,
      onTap: onPressed,
      child: SizedBox(
        height: 60,
        width: 60,
        child: Center(
            child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 24),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.77,
              child: PageView(
                controller: controller,
                children: [
                  for (var onbodardingData in myOnboarding)
                    OnboardingView(data: onbodardingData),
                ],
              ),
            ),
            Expanded(child: _buildIndicator(context)),
            Container(child: _buildButtons(context)),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;
}

final myOnboarding = [
  OnboardingData(
      image: 'assets/profiles/onboarding_1.png',
      title: 'Discover places near you',
      description:
          'We make it simple to find the food you crave, enter your address '
          'and let us do reset.'),
  OnboardingData(
      image: 'assets/profiles/onboarding_2.png',
      title: 'Order your favorite',
      description:
          'When ou order eat street, we will hook you up with exclusive '
          'coupns, special sand rewards.'),
  OnboardingData(
      image: 'assets/profiles/onboarding_3.png',
      title: 'Fastest delivery',
      description:
          'Weh make food ordering fast, simple and free no matter if you order '
          'onine or cash.'),
];
