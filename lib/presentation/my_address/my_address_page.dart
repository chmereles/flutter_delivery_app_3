import 'package:app_delivery_3/config/app_constants.dart';
import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/data/datasources/adress_data_source.dart';
import 'package:app_delivery_3/data/repositories/adress_repository_impl.dart';
import 'package:app_delivery_3/domain/entities/address/address.dart';
import 'package:app_delivery_3/l10n/l10n.dart';
import 'package:app_delivery_3/presentation/03_sign_in/views/sign_in_view.dart';
import 'package:app_delivery_3/presentation/my_address/bloc/address_bloc.dart';
import 'package:app_delivery_3/presentation/my_address/widgets/gps_fixed_widget.dart';
import 'package:app_delivery_3/presentation/my_address/widgets/pin_widget.dart';
import 'package:app_delivery_3/presentation/my_address/widgets/zoom_button_widget.dart';
import 'package:app_delivery_3/presentation/widgets/address/address_widget.dart';
import 'package:app_delivery_3/presentation/widgets/build_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MyAddressPage extends StatelessWidget {
  const MyAddressPage({Key? key}) : super(key: key);

  static String id = 'my-address-page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressBloc(
        AddressRepositoryImpl(
          AddressDataSourceImpl(),
        ),
      ),
      child: _BuildView(),
    );
  }
}

class _BuildView extends StatelessWidget {
  const _BuildView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: BuildAppBar(title: Text(l10n.myAdress)),
      body: Column(
        children: [
          //
          _BuildSearch(hint: l10n.myAdressSearch),

          //
          const Expanded(child: BuildMap()),

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
  }) : super(key: key);

  @override
  State<BuildMap> createState() => _BuildMapState();
}

class _BuildMapState extends State<BuildMap> {
  //
  late final MapController _mapController;
  final Location _locationService = Location();
  LocationData? _currentLocation;
  String? _serviceError = '';

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    _mapController.mapEventStream.listen((event) {
      if (event is MapEventMoveEnd ||
          event is MapEventFlingAnimationEnd ||
          event is MapEventDoubleTapZoomEnd ||
          event is MapEventRotateEnd) {
        _centerMarker(context);
        print(event);
      }
    });
    initLocationService();
  }

  Future<void> _centerMarker(BuildContext context) async {
    context
        .read<AddressBloc>()
        .add(AddressSolicited(point: _mapController.center));

    final data = {
      'latitude': _mapController.center.latitude,
      'longitude': _mapController.center.longitude
    };
    _currentLocation = LocationData.fromMap(data);
    setState(() {});
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

  Future<void> _centerMap() async {
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

  Widget _controller(Color color) {
    return SizedBox(
      height: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BuildGpsFixed(onTap: _centerMap),
          ZoomButtonWidget(
            mapController: _mapController,
            currentLocation: _currentLocation,
          ),
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
        // mapa
        FlutterMap(
          mapController: _mapController,
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

        // controlador mapa, posicion actual + zoom
        Positioned(
          bottom: 10,
          right: 0,
          child: _controller(primaryColor),
        ),

        // texto con la direccion
        Align(
          alignment: const Alignment(0, 0.1),
          child: BlocBuilder<AddressBloc, AddressState>(
            builder: (context, state) {
              var address = 'x';

              if (state is AddressLoaded) {
                address = state.address.streetName;
              }

              return Text(address);
            },
          ),
        ),

        // ping address
        Align(
          child: BuildPinMap(color: primaryColor),
        )
      ],
    );
  }
}

class _BuildSave extends StatelessWidget {
  const _BuildSave({Key? key}) : super(key: key);

  void _onPressSaveButton(BuildContext context, Address address) {
    Navigator.pop(context, address);
  }

  @override
  Widget build(BuildContext context) {
    print(':BUILD SAVE:');

    return Container(
      // height: 150,
      color: Colors.red,
      child: SizedBox(
        height: 50,
        child: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            Address? address;

            if (state is AddressLoaded) {
              address = state.address;
            }

            return ElevatedButton(
              child: const Text('Save'),
              onPressed: address != null
                  ? () => _onPressSaveButton(context, address!)
                  : null,
            );
          },
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
