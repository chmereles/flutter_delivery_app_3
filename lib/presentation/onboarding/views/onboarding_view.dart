import 'package:app_delivery_3/presentation/widgets/rating_widget.dart';
import 'package:flutter/material.dart';

import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/presentation/onboarding/onboarding_page.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key, required this.data}) : super(key: key);

  final OnboardingData data;
  @override
  Widget build(BuildContext context) {
    return Stack(
      // mainAxisSize: MainAxisSize.max,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: const Alignment(0, -0.5),
          child: Image.asset(data.image),
        ),
        Align(
          alignment: const Alignment(0, 0.45),
          child: SizedBox(
            // decoration: BoxDecoration(border: Border.all()),
            // color: Colors.amber,
            height: SizeConfig.screenHeight * 0.1,
            child: Center(
              child: Text(
                data.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        //
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            // decoration: BoxDecoration(border: Border.all()),
            height: SizeConfig.screenHeight * 0.2,
            // color: Colors.blue,
            // width: SizeConfig.screenWidth,
            margin: const EdgeInsets.symmetric(horizontal: 19),
            child: Center(
              child: Text(
                data.description,
                style: const TextStyle(fontSize: 20, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
