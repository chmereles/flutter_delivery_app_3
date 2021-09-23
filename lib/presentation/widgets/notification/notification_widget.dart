import 'package:flutter/material.dart';

const notificationSize = 15.0;
const notification = '2';
const textStyle = TextStyle(fontSize: 11, color: Colors.white);
const splashRadius = 25.0;

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  void _onPressed() {
    print('button pressed');
  }

  @override
  Widget build(BuildContext context) {
    final notificationColor = Theme.of(context).colorScheme.secondary;

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
                        // color: Colors.black,
                        color: notificationColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
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
}
