import 'package:app_delivery_3/presentation/08_my_order/views/live_location.dart';
import 'package:app_delivery_3/presentation/08_my_order/views/my_order.dart';
import 'package:app_delivery_3/presentation/08_my_order/views/track_order.dart';
import 'package:flutter/material.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  static String id = 'my-order-page';

  @override
  Widget build(BuildContext context) {
    return TrackOrderView();
    // return LiveLocationPage();
  }
}
