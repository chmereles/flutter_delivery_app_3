import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  var cant = 0;

  final cantStyle = const TextStyle(fontWeight: FontWeight.bold);

  void _updateCant(int val) {
    cant = cant + val;
    if (cant < 0) {
      cant = 0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (cant > 0)
          ChangeCantButton(
            iconData: Icons.remove_circle_outline,
            onPressed: () => _updateCant(-1),
            color: Colors.grey,
          ),
        if (cant > 0)
          SizedBox(
            width: 20,
            child: Center(child: Text('$cant', style: cantStyle)),
          ),
        ChangeCantButton(
          iconData: Icons.add_circle,
          onPressed: () => _updateCant(1),
          color: Theme.of(context).accentColor,
        ),
      ],
    );
  }
}

class ChangeCantButton extends StatelessWidget {
  const ChangeCantButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      radius: 20,
      onTap: onPressed,
      child: Icon(
        iconData,
        color: color,
      ),
    );
  }
}
