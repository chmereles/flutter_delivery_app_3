import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/l10n/l10n.dart';
import 'package:app_delivery_3/presentation/08_my_order/views/live_location.dart';
import 'package:app_delivery_3/presentation/my_address/my_address_page.dart';
import 'package:app_delivery_3/presentation/widgets/address/address_widget.dart';
import 'package:app_delivery_3/presentation/widgets/botton_sheet/custom_botton_sheet.dart';
import 'package:app_delivery_3/presentation/widgets/build_app_bar.dart';
import 'package:app_delivery_3/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

final bottomSheetHeight = SizeConfig.screenHeight * 0.5;

class SaveAddressPage extends StatelessWidget {
  const SaveAddressPage({Key? key}) : super(key: key);

  static String id = 'save-address-page';

  @override
  Widget build(BuildContext context) {
    return _BuildView();
  }
}

class _BuildView extends StatelessWidget {
  const _BuildView({Key? key}) : super(key: key);

  //TODO pasar a widget
  Widget _circleButton(
    Color color1,
    Color color2,
    IconData iconData, [
    double size = 60,
  ]) {
    return SizedBox(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final heightBottomSheet = SizeConfig.screenHeight * 0.50;
    final heightMap = SizeConfig.screenHeight * 0.50;
    final l10n = context.l10n;

    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.red,
      appBar: BuildAppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: _circleButton(
              primaryColor,
              Colors.white,
              Icons.gps_fixed_outlined,
              40,
            ),
          )
        ],
      ),
      body: _BuildMap(height: heightMap),
      bottomSheet: CustomButtonSheet(
        height: heightBottomSheet,
        child: Padding(
          padding: const EdgeInsets.only(left: 22, right: 22, bottom: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BuildTitle(l10n: l10n),
              const Divider(height: 20),
              _BuildYourLocation(l10n: l10n),
              const Divider(height: 20),
              _BuildTagLocation(l10n: l10n),
              const SizedBox(height: 20),
              CustomButton(
                height: 40,
                child: Text(l10n.saveAddressSave),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildPin extends StatelessWidget {
  const _BuildPin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    const iconSize = 50.0;

    return Stack(
      children: [
        Center(
          child: Container(
            height: iconSize / 1,
            width: iconSize / 1,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Center(
        //   child: Container(
        //     height: iconSize / 1.7,
        //     width: iconSize / 1.7,
        //     decoration: BoxDecoration(
        //       color: primaryColor.withOpacity(0.15),
        //       shape: BoxShape.circle,
        //     ),
        //   ),
        // ),
        Center(
          child: Container(
            height: iconSize / 4,
            width: iconSize / 4,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, -iconSize / 3),
            child: Icon(
              Icons.location_on,
              size: iconSize / 1.2,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _BuildMap extends StatelessWidget {
  const _BuildMap({Key? key, this.height}) : super(key: key);

  final double? height;
  @override
  Widget build(BuildContext context) {
    const urlTemplate = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
    const subdomains = ['a', 'b', 'c'];

    return SizedBox(
      height: height,
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(-28.388015, -65.7011089),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            // attributionBuilder: (_) {
            //   return Text("© OpenStreetMap contributors");
            // },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(-28.388015, -65.7011089),
                builder: (ctx) => Container(
                  child: _BuildPin(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BuildTitle extends StatelessWidget {
  const _BuildTitle({Key? key, required this.l10n}) : super(key: key);
  final AppLocalizations l10n;
  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );

    return Text(
      l10n.saveAddressSelectLocation,
      style: style,
    );
  }
}

class _BuildYourLocation extends StatelessWidget {
  const _BuildYourLocation({Key? key, required this.l10n}) : super(key: key);

  final AppLocalizations l10n;

  void _goToMyaddres(BuildContext context) {
    Navigator.of(context).pushNamed(MyAddressPage.id);
    // Navigator.of(context).pushNamed(LiveLocationPage.route.id);
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: Theme.of(context).colorScheme.secondary,
      fontWeight: FontWeight.bold,
    );
    final addressWidth = SizeConfig.screenWidth * 0.7;
    final height = SizeConfig.screenHeight * 0.08;

    return Container(
      // color: Colors.amber,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.saveAddressYourLocation),
          Row(
            children: [
              AddressWidget(
                width: addressWidth,
                address: 'completar***',
                showExpand: false,
              ),
              const Spacer(),
              InkWell(
                onTap: () => _goToMyaddres(context),
                child: Text(l10n.saveAddressChange, style: style),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _BuildTagLocation extends StatefulWidget {
  const _BuildTagLocation({Key? key, required this.l10n}) : super(key: key);

  final AppLocalizations l10n;
  @override
  State<_BuildTagLocation> createState() => _BuildTagLocationState();
}

class _BuildTagLocationState extends State<_BuildTagLocation> {
  final height = SizeConfig.screenHeight * 0.12;
  final buttonWidth = SizeConfig.screenWidth * 0.23;

  int _selectedButton = 1;

  void _updateIndex(int index) {
    setState(() {
      _selectedButton = index;
    });
  }

  Widget _button(BuildContext context, String text, int index) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: buttonWidth),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: _selectedButton == index
              ? Theme.of(context).colorScheme.secondary
              : Colors.grey,
        ),
        onPressed: () => _updateIndex(index),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.green,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.l10n.saveAddressTag),
          Row(
            children: [
              _button(context, widget.l10n.saveAddressHome, 1),
              const Spacer(),
              _button(context, widget.l10n.saveAddressWork, 2),
              const Spacer(),
              _button(context, widget.l10n.saveAddressOther, 3),
            ],
          )
        ],
      ),
    );
  }
}
