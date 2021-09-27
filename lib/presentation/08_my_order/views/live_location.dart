import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

// import '../widgets/drawer.dart';

class LiveLocationPage extends StatefulWidget {
  static const String route = '/live_location';

  @override
  _LiveLocationPageState createState() => _LiveLocationPageState();
}

class _LiveLocationPageState extends State<LiveLocationPage> {
  LocationData? _currentLocation;
  late final MapController _mapController;

  bool _liveUpdate = false;
  bool _permission = false;

  String? _serviceError = '';

  int interActiveFlags = InteractiveFlag.all;

  final Location _locationService = Location();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    _mapController.mapEventStream.listen((event) {
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

  Future<void> initLocationService() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    // LocationData _locationData;

    _serviceEnabled = await _locationService.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationService.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _locationService.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    // await _locationService.changeSettings(
    //   // accuracy: LocationAccuracy.high,
    //   interval: 2000,
    // );

    LocationData? location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        final permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.granted;

        if (_permission) {
          // location = await _locationService.getLocation();
          // _currentLocation = location;
          // _locationService.onLocationChanged
          //     .listen((LocationData result) async {
          //   if (mounted) {
          //     setState(() {
          //       _currentLocation = result;

          //       // If Live Update is enabled, move map center
          //       if (_liveUpdate) {
          //         _mapController.move(
          //             LatLng(
          //               _currentLocation!.latitude!,
          //               _currentLocation!.longitude!,
          //             ),
          //             _mapController.zoom);
          //       }
          //     });
          //   }
          // });
          _centerMap();
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
      }
      location = null;
    }
  }

  void _centerMap() async {
    final location = await _locationService.getLocation();
    _currentLocation = location;
    _mapController.move(
        LatLng(
          _currentLocation!.latitude!,
          _currentLocation!.longitude!,
        ),
        _mapController.zoom);

    setState(() {});
  }

  void _centerMarker() async {
    final data = {
      'latitude': _mapController.center.latitude,
      'longitude': _mapController.center.longitude
    };
    _currentLocation = LocationData.fromMap(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('::build::');

    LatLng currentLatLng;

    // Until currentLocation is initially updated, Widget can locate to 0, 0
    // by default or store previous location value to show.
    if (_currentLocation != null) {
      currentLatLng = LatLng(
        _currentLocation!.latitude!,
        _currentLocation!.longitude!,
      );
    } else {
      currentLatLng = LatLng(0, 0);
    }

    final markers = <Marker>[
      Marker(
        width: 80,
        height: 80,
        point: currentLatLng,
        builder: (ctx) => const FlutterLogo(
          textColor: Colors.blue,
          key: ObjectKey(Colors.blue),
        ),
      ),
    ];

    return Scaffold(
      // appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            //
            _buildHeader(currentLatLng),

            //
            _BuildFlutterMap(
              mapController: _mapController,
              currentLatLng: currentLatLng,
              markers: markers,
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  // Widget _buildFlutterMap(LatLng currentLatLng, List<Marker> markers) {}

  Padding _buildHeader(LatLng currentLatLng) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: _serviceError!.isEmpty
          ? Column(
              children: [
                const Text('This is a map that is showing'),
                Text(
                  '(${currentLatLng.latitude}, ${currentLatLng.longitude},).',
                ),
                // Text(_mapController.center.toString()),
              ],
            )
          : Text('Error occured while acquiring location. Error Message : '
              '$_serviceError'),
    );
  }

  Builder _buildFAB() {
    return Builder(builder: (BuildContext context) {
      return FloatingActionButton(
        onPressed: () {
          _centerMap();
          // _centerMarker();

          // print(_mapController.center.toString());
          // setState(() {
          //   _liveUpdate = !_liveUpdate;

          //   if (_liveUpdate) {
          //     interActiveFlags = InteractiveFlag.rotate |
          //         InteractiveFlag.pinchZoom |
          //         InteractiveFlag.doubleTapZoom;

          //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //       content: Text(
          //           'In live update mode only zoom and rotation are enable'),
          //     ));
          //   } else {
          //     interActiveFlags = InteractiveFlag.all;
          //   }
          // });
        },
        child: _liveUpdate ? Icon(Icons.location_on) : Icon(Icons.location_off),
      );
    });
  }
}

class _BuildFlutterMap extends StatelessWidget {
  const _BuildFlutterMap({
    Key? key,
    required this.mapController,
    required this.currentLatLng,
    required this.markers,
  }) : super(key: key);

  final MapController mapController;
  final LatLng currentLatLng;
  final List<Marker> markers;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: LatLng(currentLatLng.latitude, currentLatLng.longitude),
          zoom: 12,
          // interactiveFlags: interActiveFlags,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            // For example purposes. It is recommended to use
            // TileProvider with a caching and retry strategy, like
            // NetworkTileProvider or CachedNetworkTileProvider
            tileProvider: NonCachingNetworkTileProvider(),
          ),
          MarkerLayerOptions(markers: markers)
        ],
      ),
    );
  }
}
