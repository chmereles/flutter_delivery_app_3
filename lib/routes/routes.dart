import 'package:app_delivery_3/presentation/03_sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';

import 'package:app_delivery_3/presentation/02_welcome/welcome_page.dart';
import 'package:app_delivery_3/presentation/onboarding_page.dart';

final ruotes = <String, WidgetBuilder>{
  WelcomePage.id: (BuildContext context) => const WelcomePage(),
  OnboardingPage.id: (BuildContext context) => const OnboardingPage(),
  SignInPage.id: (BuildContext context) => const SignInPage(),
  // OrderStatusPage.id: (BuildContext context) => OrderStatusPage(),
  // YourOrderPage.id: (BuildContext context) => YourOrderPage(),
};
