import 'package:app_delivery_3/presentation/my_address/widgets/circle_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class ZoomButtonWidget extends StatelessWidget {
  const ZoomButtonWidget({
    Key? key,
    required this.mapController,
    required this.currentLocation,
  }) : super(key: key);

  final MapController mapController;
  final LocationData? currentLocation;

  void _onChangeZoom(double inc) {
    final newZoom = (mapController.zoom + inc).clamp(0.0, 18.0);

    mapController.move(
        LatLng(
          currentLocation!.latitude!,
          currentLocation!.longitude!,
        ),
        newZoom);

    print('zoom: ${mapController.zoom}');
  }

  void _onincZoom() {
    _onChangeZoom(1);
  }

  void _ondecZoom() {
    _onChangeZoom(-1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BuildPlusButton(onTap: _onincZoom),
        BuildMinusButton(onTap: _ondecZoom),
      ],
    );
  }
}

class BuildMinusButton extends StatelessWidget {
  const BuildMinusButton({Key? key, this.onTap}) : super(key: key);

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return BuildCircleButton(
      color1: Colors.white,
      color2: Theme.of(context).colorScheme.secondary,
      iconData: Icons.remove,
      size: 35,
      onTap: onTap,
    );
  }
}

class BuildPlusButton extends StatelessWidget {
  const BuildPlusButton({Key? key, this.onTap}) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BuildCircleButton(
      color1: Colors.white,
      color2: Theme.of(context).colorScheme.secondary,
      iconData: Icons.add,
      size: 35,
      onTap: onTap,
    );
  }
}
