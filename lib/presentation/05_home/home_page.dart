import 'package:flutter/material.dart';

import 'package:app_delivery_3/presentation/05_home/views/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static String id = 'home-page';
  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}
