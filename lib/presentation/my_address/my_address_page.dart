import 'package:app_delivery_3/config/app_constants.dart';
import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/l10n/l10n.dart';
import 'package:app_delivery_3/presentation/03_sign_in/views/sign_in_view.dart';
import 'package:app_delivery_3/presentation/widgets/address/address_widget.dart';
import 'package:app_delivery_3/presentation/widgets/build_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

const _iconSize = 60.0;

class MyAddressPage extends StatelessWidget {
  const MyAddressPage({Key? key}) : super(key: key);

  static String id = 'my-address-page';

  @override
  Widget build(BuildContext context) {
    return _BuildView();
  }
}

class _BuildView extends StatefulWidget {
  const _BuildView({Key? key}) : super(key: key);

  @override
  State<_BuildView> createState() => _BuildViewState();
}

class _BuildViewState extends State<_BuildView> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    // _mapController
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: BuildAppBar(
        title: Text(l10n.myAdress),
      ),
      body: Column(
        children: [
          //
          _BuildSearch(hint: l10n.myAdressSearch),

          //
          Expanded(
            child: BuildMap(mapController: _mapController),
          ),

          //
          const _BuildSave(),
        ],
      ),
    );
  }
}

class _BuildSearch extends StatelessWidget {
  const _BuildSearch({Key? key, required this.hint}) : super(key: key);

  final String hint;
  @override
  Widget build(BuildContext context) {
    print(':BUILD SEARCH:');

    const address = '9 st. New York City';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildTextField(
            hintText: hint,
            prefixIconData: Icons.search_outlined,
          ),
          const SizedBox(height: 10),
          AddressWidget(
            width: SizeConfig.screenWidth * 0.8,
            address: address,
            showExpand: false,
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class BuildMap extends StatefulWidget {
  const BuildMap({
    Key? key,
    required this.mapController,
  }) : super(key: key);

  final MapController mapController;

  @override
  State<BuildMap> createState() => _BuildMapState();
}

class _BuildMapState extends State<BuildMap> {
  //
  final Location _locationService = Location();
  LocationData? _currentLocation;
  String? _serviceError = '';

  @override
  void initState() {
    super.initState();

    widget.mapController.mapEventStream.listen((event) {
      if (event is MapEventMoveEnd ||
          event is MapEventFlingAnimationEnd ||
          event is MapEventDoubleTapZoomEnd ||
          event is MapEventRotateEnd) {
        _centerMarker();
        print(event);
      }
    });
    initLocationService();
  }

  Future<bool> get serviceEnabled async {
    var enabled = await _locationService.serviceEnabled();
    if (!enabled) {
      enabled = await _locationService.requestService();
    }
    return enabled;
  }

  Future<bool> get permissionGranted async {
    var permissionStatus = await _locationService.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _locationService.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<void> initLocationService() async {
    if (!await serviceEnabled) {
      return;
    }

    if (!await permissionGranted) {
      return;
    }

    try {
      _centerMap();
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
      }
      // location = null;
    }
  }

  Future<void> _centerMarker() async {
    var lat = widget.mapController.center.latitude;
    var lon = widget.mapController.center.longitude;
    var lon1 = lon + 0.00015;

    print('dir1: $lon, $lat');
    print('dir2: $lon1, $lat');

    final data = {
      'latitude': widget.mapController.center.latitude,
      'longitude': widget.mapController.center.longitude
    };
    _currentLocation = LocationData.fromMap(data);
    setState(() {});
  }

  Future<void> _centerMap() async {
    final location = await _locationService.getLocation();
    _currentLocation = location;
    widget.mapController.move(
        LatLng(
          _currentLocation!.latitude!,
          _currentLocation!.longitude!,
        ),
        widget.mapController.zoom);

    setState(() {});
  }

  void _changeZoom(double inc) {
    final newZoom = (widget.mapController.zoom + inc).clamp(0.0, 18.0);

    widget.mapController.move(
        LatLng(
          _currentLocation!.latitude!,
          _currentLocation!.longitude!,
        ),
        newZoom);

    print('zoom: ${widget.mapController.zoom}');
  }

  void _incZoom() {
    _changeZoom(1);
  }

  void _decZoom() {
    _changeZoom(-1);
  }

  Widget _controller(Color color) {
    return SizedBox(
      height: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BuildGpsFixed(onTap: _centerMap),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BuildPlusButton(onTap: _incZoom),
              BuildMinusButton(onTap: _decZoom),
            ],
          )
        ],
      ),
    );
  }

  LatLng get currentLatLng {
    // Until currentLocation is initially updated, Widget can locate to 0, 0
    // by default or store previous location value to show.
    if (_currentLocation != null) {
      return LatLng(
        _currentLocation!.latitude!,
        _currentLocation!.longitude!,
      );
    } else {
      return LatLng(0, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(':BUILD MAP:');
    print('$_currentLocation');

    final primaryColor = Theme.of(context).colorScheme.primary;

    return Stack(
      children: [
        FlutterMap(
          mapController: widget.mapController,
          options: MapOptions(
            center: currentLatLng,
            zoom: 17,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: AppConstants.openStreetMapUrlTemplate,
              subdomains: AppConstants.openStreetMapSubdomain,
              // attributionBuilder: (_) {
              //   return Text("© OpenStreetMap contributors");
              // },
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          right: 0,
          child: _controller(primaryColor),
        ),
        Align(
          child: BuildPinMap(color: primaryColor),
        )
      ],
    );
  }
}

class BuildPinMap extends StatelessWidget {
  const BuildPinMap({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: _iconSize / 1,
            width: _iconSize / 1,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: Container(
            height: _iconSize / 4,
            width: _iconSize / 4,
            decoration: BoxDecoration(
              color: color.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: const Offset(0, -_iconSize / 3),
            child: Icon(
              Icons.location_on,
              size: _iconSize / 1.2,
              color: color,
            ),
          ),
        ),
      ],
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

class BuildGpsFixed extends StatelessWidget {
  const BuildGpsFixed({Key? key, this.onTap}) : super(key: key);

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return BuildCircleButton(
      color1: Theme.of(context).colorScheme.primary,
      color2: Colors.white,
      iconData: Icons.gps_fixed_outlined,
      onTap: onTap,
    );
  }
}

class BuildCircleButton extends StatelessWidget {
  const BuildCircleButton({
    Key? key,
    required this.color1,
    required this.color2,
    required this.iconData,
    this.onTap,
    this.size = 60,
  }) : super(key: key);

  final Color color1;
  final Color color2;
  final IconData iconData;
  final double size;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: size,
        width: size,
        child: Card(
          color: color1,
          shape: const CircleBorder(),
          child: Icon(
            iconData,
            color: color2,
            size: size / 1.8,
          ),
        ),
      ),
    );
  }
}

class _BuildSave extends StatelessWidget {
  const _BuildSave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(':BUILD SAVE:');

    return Container(
      // height: 150,
      color: Colors.red,
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          child: Text('data'),
          onPressed: () {},
        ),
      ),
      // child: CustomButton(
      //   child: Text('Save'),
      //   onPressed: () {},
      //   height: 36,
      // ),
    );
  }
}
