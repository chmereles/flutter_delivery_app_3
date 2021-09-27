import 'package:app_delivery_3/presentation/00_main/main_page.dart';
import 'package:app_delivery_3/presentation/02_welcome/welcome_page.dart';
import 'package:app_delivery_3/presentation/03_sign_in/sign_in_page.dart';
import 'package:app_delivery_3/presentation/05_home/home_page.dart';
import 'package:app_delivery_3/presentation/08_my_order/my_order_page.dart';
import 'package:app_delivery_3/presentation/10_restaurant/restaurant_page.dart';
import 'package:app_delivery_3/presentation/filter/filter_page.dart';
import 'package:app_delivery_3/presentation/my_address/my_address_page.dart';
import 'package:app_delivery_3/presentation/my_address/save_address_page.dart';
import 'package:app_delivery_3/presentation/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

final ruotes = <String, WidgetBuilder>{
  MainPage.id: (BuildContext context) => const MainPage(),
  WelcomePage.id: (BuildContext context) => const WelcomePage(),
  OnboardingPage.id: (BuildContext context) => const OnboardingPage(),
  SignInPage.id: (BuildContext context) => const SignInPage(),
  HomePage.id: (BuildContext context) => const HomePage(),
  RestaurantPage.id: (BuildContext context) => const RestaurantPage(),
  FilterPage.id: (BuildContext context) => const FilterPage(),
  MyOrderPage.id: (BuildContext context) => const MyOrderPage(),
  MyAddressPage.id: (BuildContext context) => const MyAddressPage(),
  SaveAddressPage.id: (BuildContext context) => const SaveAddressPage(),
};
