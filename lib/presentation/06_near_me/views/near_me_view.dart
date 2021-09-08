import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/presentation/widgets/build_app_bar.dart';
import 'package:flutter/material.dart';

class NearMeView extends StatelessWidget {
  const NearMeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _BuildBody();
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({Key? key}) : super(key: key);

  Widget _buildTitle(BuildContext context) {
    const address = '13A Masr Street, Nuew York';
    const iconSize = 20.0;
    const textStyle = TextStyle(fontSize: 12);
    final height = SizeConfig.screenHeight * 0.038;
    final width = SizeConfig.screenWidth * 0.6;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.amber,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.pin_drop_outlined,
            size: iconSize,
          ),
          SizedBox(
            width: width * 0.7,
            child: Text(
              address,
              style: textStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(
            Icons.expand_more_outlined,
            size: iconSize,
          ),
        ],
      ),
    );
  }

  Widget _buildNotification(BuildContext context) {
    const notificationSize = 15.0;
    const notification = '2';
    const textStyle = TextStyle(fontSize: 11, color: Colors.white);
    const splashRadius = 25.0;

    void _onPressed() {
      print('button pressed');
    }

    return Container(
      // color: Colors.red,
      child: Stack(
        children: [
          IconButton(
            splashRadius: splashRadius,
            onPressed: _onPressed,
            icon: Stack(
              children: [
                const Align(
                  child: Icon(Icons.notifications_active_outlined),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      height: notificationSize,
                      width: notificationSize,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(notification, style: textStyle),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: _buildTitle(context),
        actions: [_buildNotification(context)],
      ),
    );
  }
}
