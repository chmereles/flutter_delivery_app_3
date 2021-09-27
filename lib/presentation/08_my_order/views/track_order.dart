import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/data/datasources/track_data_source.dart';
import 'package:app_delivery_3/data/repositories/track_repository_impl.dart';
import 'package:app_delivery_3/presentation/08_my_order/bloc/ticker.dart';
import 'package:app_delivery_3/presentation/08_my_order/bloc/track_bloc.dart';
import 'package:app_delivery_3/presentation/08_my_order/views/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackOrderView extends StatelessWidget {
  const TrackOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // salvdor

    return BlocProvider(
      create: (context) => TrackBloc(
          ticker: const Ticker(),
          repository: TrackRepositoryImpl(TrackDataSourceImpl()))
        ..add(TrackStarted()),
      // ,
      child: const _BuildBody(),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build body');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track order'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<TrackBloc>().add(TrackCurrentRequested());
            },
            icon: const Icon(
              Icons.access_time,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          const MapView(),
          //
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: ContainerExpanded(
              buttonChild: Container(
                color: Colors.amber,
                height: SizeConfig.screenHeight * 0.08,
                child: const Center(
                  child: Text(
                    'Orders details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              contentChild: const TripRouteView(),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerExpanded extends StatefulWidget {
  const ContainerExpanded({
    Key? key,
    required this.buttonChild,
    this.contentChild,
  }) : super(key: key);

  final Widget buttonChild;
  final Widget? contentChild;
  @override
  _ContainerExpandedState createState() => _ContainerExpandedState();
}

class _ContainerExpandedState extends State<ContainerExpanded> {
  final _maxHeight = SizeConfig.screenHeight * 0.39;
  double _animatedHeight = 0;
  int _milliseconds = 0;

  void changeHeight(double height, [int time = 0]) {
    _milliseconds = time;
    if (height < 0) {
      height = 0;
    }

    if (height > _maxHeight) {
      height = _maxHeight;
    }

    setState(() {
      _animatedHeight = height;
    });
  }

  void toggleHeight() {
    _animatedHeight != 0.0
        ? changeHeight(0, 200)
        : changeHeight(_maxHeight, 200);
  }

  void panelToggle(DragUpdateDetails details) {
    if (_animatedHeight > 0) {
      if (details.delta.dy > 10) {
        toggleHeight();
      }
    }
  }

  void panelChangeHeight(DragUpdateDetails details) {
    if (_animatedHeight > 0) {
      final height = _maxHeight - details.localPosition.dy;
      changeHeight(height);
    }
  }

  void _changeHalfHeight(DragEndDetails details) {
    if (_animatedHeight > 0 && _animatedHeight < _maxHeight) {
      if (_animatedHeight < _maxHeight / 2) {
        changeHeight(0, 200);
      } else {
        changeHeight(_maxHeight, 200);
      }
    }
  }

  Container _buildShrinkButton() {
    const colorTop = Colors.grey;
    return Container(
      height: 8,
      width: 80,
      decoration: const BoxDecoration(
        color: colorTop,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('::build plegable panel::');

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //
          GestureDetector(
            onPanUpdate: panelToggle,
            child: AnimatedContainer(
              duration: Duration(milliseconds: _milliseconds),
              height: _animatedHeight,
              width: 1,
              // color: Colors.tealAccent,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                child: Column(
                  children: [
                    //
                    GestureDetector(
                      onPanUpdate: panelChangeHeight,
                      onPanEnd: _changeHalfHeight,
                      child: _buildShrinkButton(),
                    ),
                    //
                    if (widget.contentChild != null)
                      if (_animatedHeight == _maxHeight)
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: widget.contentChild!,
                        ))
                  ],
                ),
              ),
            ),
          ),

          //
          GestureDetector(
            onTap: toggleHeight,
            child: widget.buttonChild,
          ),
        ],
      ),
    );
  }
}

class TripRouteView extends StatelessWidget {
  const TripRouteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Trip Route',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        //
        Align(
          alignment: const Alignment(0, -0.7),
          child: _buildTripRow(),
        ),

        //
        Align(
          child: buildTripIcons(),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: _buildDriverDetails(),
        ),
      ],
    );
  }

  Widget _buildTripRow() {
    const style = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
    );

    Widget _data(String text1, String text2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text1, style: style),
          Text(text2, style: style),
        ],
      );
    }

    Widget _line() {
      return SizedBox(
        width: SizeConfig.screenWidth * 0.3,
        child: const MySeparator(
          color: Colors.blue,
          height: 2,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _data('Pizza Hut', 'Street 5'),
        _line(),
        _data('Nacer City', 'Street 7'),
      ],
    );
  }

  Widget buildTripIcons() {
    const color = Colors.blue;
    const stye = TextStyle();

    Widget _iconText(String text, IconData iconData) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, color: color),
          Text(text, style: stye),
        ],
      );
    }

    Widget _separador() {
      return SizedBox(width: SizeConfig.screenWidth * 0.1);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _iconText('4.5 Km', Icons.place_outlined),
        _separador(),
        _iconText('(15 minutes)', Icons.schedule),
      ],
    );
  }

  Widget _buildDriverDetails() {
    final radius = SizeConfig.screenWidth * 0.08;

    Widget _avatar() {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.blue,
        child: CircleAvatar(
          radius: radius * 0.92,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: radius * 0.88,
            backgroundImage: NetworkImage(
                'https://cdn.pixabay.com/photo/2018/01/15/07/52/woman-3083390_1280.jpg'),
          ),
        ),
      );
    }

    Widget _text() {
      const style1 = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      );

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Driver 1', style: style1),
          const Text('Driver 1'),
        ],
      );
    }

    Widget _button(String text, Color color) {
      const style = TextStyle(fontSize: 12);
      return SizedBox(
        height: 35,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            primary: color,
          ),
          child: Text(
            text,
            style: style,
          ),
        ),
      );
    }

    return Row(
      children: [
        _avatar(),
        const SizedBox(width: 8),
        _text(),
        const Spacer(),
        _button('boton 1', Colors.red),
        const SizedBox(width: 10),
        _button('boton 2', Colors.green),
      ],
    );
  }
}

class Dragable extends StatelessWidget {
  const Dragable({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.13,
      minChildSize: 0.13,
      maxChildSize: 0.5,
      // expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.amber,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Stack(
              children: [
                child,
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: Colors.red,
                    height: 50,

                    // width: 10,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
