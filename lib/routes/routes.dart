import 'package:app_delivery_3/presentation/00_main/main_page.dart';
import 'package:app_delivery_3/presentation/03_sign_in/sign_in_page.dart';
import 'package:app_delivery_3/presentation/05_home/home_page.dart';
import 'package:app_delivery_3/presentation/10_restaurant/restaurant_page.dart';
import 'package:flutter/material.dart';

import 'package:app_delivery_3/presentation/02_welcome/welcome_page.dart';
import 'package:app_delivery_3/presentation/onboarding/onboarding_page.dart';

final ruotes = <String, WidgetBuilder>{
  MainPage.id: (BuildContext context) => const MainPage(),
  WelcomePage.id: (BuildContext context) => const WelcomePage(),
  OnboardingPage.id: (BuildContext context) => const OnboardingPage(),
  SignInPage.id: (BuildContext context) => const SignInPage(),
  HomePage.id: (BuildContext context) => const HomePage(),
  RestaurantPage.id: (BuildContext context) => const RestaurantPage(),
  // YourOrderPage.id: (BuildContext context) => YourOrderPage(),
};
