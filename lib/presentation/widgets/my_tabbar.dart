import 'package:flutter/material.dart';

class MyTabBar extends StatefulWidget {
  const MyTabBar({Key? key, required this.myTabs}) : super(key: key);

  final List<List<Widget>> myTabs;

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: widget.myTabs[0].length,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // tabBar
        TabBar(
          controller: _tabController,
          indicatorWeight: 3,
          isScrollable: true,
          // labelPadding: const EdgeInsets.only(top: 12, bottom: 6),
          labelColor: Theme.of(context).accentColor,
          unselectedLabelColor: Theme.of(context).primaryColor,
          indicatorSize: TabBarIndicatorSize.label,
          // indicatorPadding: const EdgeInsets.only(top: 0, bottom: 0),
          // labelStyle: const TextStyle(
          //   fontSize: 18,
          //   fontWeight: FontWeight.bold,
          // ),
          // tabs: [...myTabs],
          // tabs: const <Widget>[
          //   Text('Details'),
          //   Text('Review'),
          // ],
          tabs: widget.myTabs[0],
        ),

        // tabBarView
        Expanded(
          child: TabBarView(
            controller: _tabController,
            // children: const <Widget>[
            //   Text('details'),
            //   Text('Review'),
            // ],
            children: widget.myTabs[1],
          ),
        ),
      ],
    );
  }
}
