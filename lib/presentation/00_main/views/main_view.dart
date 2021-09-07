import 'package:app_delivery_3/presentation/05_home/views/home_view.dart';
import 'package:app_delivery_3/presentation/06_near_me/views/near_me_view.dart';
import 'package:app_delivery_3/presentation/07_cart/views/cart_view.dart';
import 'package:app_delivery_3/presentation/08_my_order/views/my_order.dart';
import 'package:app_delivery_3/presentation/09_account/views/account_view.dart';
import 'package:flutter/material.dart';
import 'package:app_delivery_3/presentation/00_main/bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const views = [
  HomeView(),
  NearMeView(),
  CartView(),
  MyOrderView(),
  AccountView(),
];

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  Widget _builNavigationBar(BuildContext context, int index) {
    return BottomNavigationBar(
      onTap: (index) {
        context.read<MainBloc>().add(SelectedTab(index));
      },
      currentIndex: index,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.red,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_outline),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: views[state.tabIndex],
          bottomNavigationBar: _builNavigationBar(context, state.tabIndex),
        );
      },
    );
  }
}
