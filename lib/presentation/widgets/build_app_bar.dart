import 'package:flutter/material.dart';

class BuildAppBar extends StatelessWidget with PreferredSizeWidget {
  const BuildAppBar({
    Key? key,
    required this.title,
    this.actions,
  }) : super(key: key);

  final Widget title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // automaticallyImplyLeading: false,
      title: title,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      textTheme: Theme.of(context).textTheme,
      iconTheme: const IconThemeData(),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
