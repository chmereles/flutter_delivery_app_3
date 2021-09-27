import 'package:flutter/material.dart';

class BuildAppBar extends StatelessWidget with PreferredSizeWidget {
  const BuildAppBar({
    Key? key,
    this.title,
    this.actions,
  }) : super(key: key);

  final Widget? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final color = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? Colors.black
        : Colors.white;
    return AppBar(
      title: title,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: color,
      elevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
