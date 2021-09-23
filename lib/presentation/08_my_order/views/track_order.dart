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
      // ..add(TrackStarted())
      ,
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
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Flexible(
              child: BlocBuilder<TrackBloc, TrackState>(
                buildWhen: (prev, state) =>
                    prev.track.currentPoint != state.track.currentPoint,
                builder: (context, state) {
                  print('::currentPoint::');

                  // if (state is TrackInitial) {
                  //   return const CircularProgressIndicator();
                  // }

                  return Stack(
                    children: [
                      MapView(track: state.track),
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: TripRouteView(),
                      // ),
                      // TripRouteView(),

                      ContainerExpanded(
                        buttonChild: Container(
                          child: Text('Orders details'),
                        ),
                      ),

                      // Dragable(
                      //     child: Container(
                      //   child: Text('data'),
                      // )),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TripRouteView extends StatelessWidget {
  const TripRouteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final bottom = SizeConfig.screenWidth * 0.05;
    final side = SizeConfig.screenWidth * 0.06;
    final heightShrink = SizeConfig.screenHeight * 0.075;
    final heightExpanded = SizeConfig.screenHeight * 0.396;

    return Positioned(
      bottom: side,
      left: side,
      right: side,
      height: heightExpanded,
      child: Container(
        color: Colors.amber,
        child: Column(
          children: [
            //
            _buildShrinkButton(),

            //
            _buildTripRow(),

            //
            buildTripIcons(),

            //
            _buildDriverDetails(),
            //
            _buildDetailsButton(heightShrink),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverDetails() {
    final radius = SizeConfig.screenWidth * 0.08;

    return Row(
      children: [
        CircleAvatar(
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
        ),
        Column(
          children: [
            Text('Driver 1'),
            Text('Driver 1'),
          ],
        ),
        Spacer(),
        ElevatedButton(onPressed: () {}, child: Text('adfadf')),
        Spacer(),
        ElevatedButton(onPressed: () {}, child: Text('adfadf')),
      ],
    );
  }

  Container _buildDetailsButton(double heightShrink) {
    return Container(
      height: heightShrink,
      width: SizeConfig.screenWidth,
      color: Colors.red,
      child: Center(child: Text('Order details')),
    );
  }

  Row buildTripIcons() {
    return Row(
      children: [
        Column(
          children: [
            Icon(Icons.place_outlined),
            Text('data'),
          ],
        ),
        Spacer(),
        Column(
          children: [
            Icon(Icons.schedule),
            Text('data'),
          ],
        ),
      ],
    );
  }

  Row _buildTripRow() {
    return Row(
      children: [
        Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            Text('data'),
            Text('data'),
          ],
        ),
        Spacer(),
        Expanded(
          child: Container(
            color: Colors.blue,
            height: 5,
          ),
        ),
        Spacer(),
        Column(
          children: [
            Text('data'),
            Text('data'),
          ],
        ),
      ],
    );
  }

  Container _buildShrinkButton() {
    return Container(
      width: 100,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.grey,
        // borderRadius: Border,
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
  double _animatedHeight = 0;
  final _maxHeight = 200.0;
  int _milliseconds = 0;

  void changeHeight(double height) {
    _milliseconds = 0;
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
    _milliseconds = 200;
    setState(() {
      _animatedHeight != 0.0
          ? _animatedHeight = 0.0
          : _animatedHeight = _maxHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    const colorTop = Colors.grey;

    return Stack(
      children: <Widget>[
        Positioned(
          left: 10,
          right: 10,
          bottom: 10,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  onPanUpdate: (DragUpdateDetails details) {
                    // print('distance: ${details.delta.distance}');
                    // double a = 200

                    if (_animatedHeight > 0) {
                      if (details.delta.dy > 10) {
                        toggleHeight();
                      } else {
                        final height = _maxHeight - details.localPosition.dy;
                        // if (height < _animatedHeight) {
                        changeHeight(height);
                        // }
                      }
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: _milliseconds),
                    child: Column(
                      children: [
                        Container(
                          height: 8,
                          width: 80,
                          decoration: const BoxDecoration(
                            color: colorTop,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        if (widget.contentChild != null) widget.contentChild!
                      ],
                    ),
                    height: _animatedHeight,
                    color: Colors.tealAccent,
                    width: 100,
                  ),
                ),
                GestureDetector(
                  onTap: toggleHeight,
                  child: widget.buttonChild,
                ),
              ],
            ),
          ),
        )
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
