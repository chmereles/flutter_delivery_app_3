import 'package:app_delivery_3/config/app_constants.dart';
import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/data/datasources/app_data_source.dart';
import 'package:app_delivery_3/data/repositories/app_repository_impl.dart';
import 'package:app_delivery_3/domain/entities/address/address.dart';
import 'package:app_delivery_3/domain/entities/address/delivery_address.dart';
import 'package:app_delivery_3/l10n/l10n.dart';
import 'package:app_delivery_3/presentation/my_address/bloc/delivery_address_bloc.dart';
import 'package:app_delivery_3/presentation/my_address/my_address_page.dart';
import 'package:app_delivery_3/presentation/my_address/widgets/gps_fixed_widget.dart';
import 'package:app_delivery_3/presentation/my_address/widgets/pin_widget.dart';
import 'package:app_delivery_3/presentation/widgets/address/address_widget.dart';
import 'package:app_delivery_3/presentation/widgets/botton_sheet/custom_botton_sheet.dart';
import 'package:app_delivery_3/presentation/widgets/build_app_bar.dart';
import 'package:app_delivery_3/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

final bottomSheetHeight = SizeConfig.screenHeight * 0.5;

class SaveAddressPage extends StatelessWidget {
  const SaveAddressPage({Key? key}) : super(key: key);

  static String id = 'save-address-page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliveryAddressBloc(
        AppRepositoryImpl(dataSource: AppDataSourceLocalImpl()),
      )..add(const DeliveryAdrressInitRequested()),
      child: const _BuildView(),
    );
  }
}

class _BuildView extends StatelessWidget {
  const _BuildView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightBottomSheet = SizeConfig.screenHeight * 0.50;
    final heightMap = SizeConfig.screenHeight * 0.50;
    final l10n = context.l10n;

    void _getAddress(BuildContext context, Tag tag) {
      context.read<DeliveryAddressBloc>().add(DeliveryAdrressRequested(tag));
    }

    // void _saveAddress(BuildContext context, Address address, Tag tag) {
    //   context.read<DeliveryAddressBloc>().add(
    //         DeliveryAdrressSaved(
    //           address: address,
    //           tag: tag,
    //         ),
    //       );
    // }

    void _chagAddress(BuildContext context, Address address) {
      context.read<DeliveryAddressBloc>().add(
            DeliveryAdrressChanged(
              address: address,
            ),
          );
    }

    return BlocBuilder<DeliveryAddressBloc, DeliveryAddressState>(
      builder: (context, state) {
        //
        // if (state.status == DeliveryAddressStatus.pending) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        //
        // if (state.status == DeliveryAddressStatus.available) {
        final currentPoint = LatLng(
          state.address.address.latitude,
          state.address.address.longitude,
        );

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: const BuildAppBar(
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: BuildGpsFixed(
                  size: 35,
                ),
              ),
            ],
          ),
          body: state.status == DeliveryAddressStatus.pending
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _BuildMap(
                  height: heightMap,
                  currentPoint: currentPoint,
                ),
          bottomSheet: state.status == DeliveryAddressStatus.pending
              ? null
              : MyButtonSheet(
                  heightBottomSheet: heightBottomSheet,
                  l10n: l10n,
                  state: state,
                ),
        );
        // }

        //
        // return Text(DeliveryAddressStatus.unavailable.toString());
      },
    );
  }
}

class MyButtonSheet extends StatelessWidget {
  const MyButtonSheet({
    Key? key,
    required this.heightBottomSheet,
    required this.l10n,
    required this.state,
  }) : super(key: key);

  final double heightBottomSheet;
  final AppLocalizations l10n;
  final DeliveryAddressState state;
  @override
  Widget build(BuildContext context) {
    return CustomButtonSheet(
      height: heightBottomSheet,
      child: Padding(
        padding: const EdgeInsets.only(left: 22, right: 22, bottom: 22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BuildTitle(l10n: l10n),
            const Divider(height: 20),
            //
            _StreetWidget(l10n: l10n),
            const Divider(height: 20),
            //
            _BuildTagLocation(l10n: l10n),
            const SizedBox(height: 20),

            //
            _SaveButton(l10n: l10n, address: state.address),
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    Key? key,
    required this.l10n,
    required this.address,
  }) : super(key: key);

  final AppLocalizations l10n;
  final DeliveryAddress address;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      height: 40,
      onPressed: address.tag != Tag.none
          ? () {
              context.read<DeliveryAddressBloc>().add(
                    DeliveryAdrressSaved(address: address),
                  );
            }
          : null,
      child: Text(l10n.saveAddressSave),
    );
  }
}

class _BuildMap extends StatelessWidget {
  const _BuildMap({
    Key? key,
    this.height,
    required this.currentPoint,
  }) : super(key: key);

  final double? height;
  final LatLng currentPoint;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    print(currentPoint);

    return SizedBox(
      height: height,
      child: FlutterMap(
        options: MapOptions(
          // center: LatLng(-28.388015, -65.7011089),
          center: currentPoint,
          zoom: 4,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: AppConstants.openStreetMapUrlTemplate,
            subdomains: AppConstants.openStreetMapSubdomain,
            // attributionBuilder: (_) {
            //   return Text("© OpenStreetMap contributors");
            // },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80,
                height: 80,
                // point: LatLng(-28.388015, -65.7011089),
                point: currentPoint,
                builder: (ctx) => BuildPinMap(
                  color: primaryColor,
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

class _StreetWidget extends StatelessWidget {
  const _StreetWidget({
    Key? key,
    required this.l10n,
    // required this.address,
  }) : super(key: key);

  final AppLocalizations l10n;
  // final DeliveryAddress address;

  Future<void> _goToMyaddres(BuildContext context) async {
    final address = await Navigator.of(context).pushNamed(MyAddressPage.id);

    if (address is Address) {
      await Future<dynamic>.delayed(Duration.zero).then((dynamic value) {
        context
            .read<DeliveryAddressBloc>()
            .add(DeliveryAdrressChanged(address: address));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.select((DeliveryAddressBloc b) => b.state);
    final isLoading = state.status == DeliveryAddressStatus.loading;
    final address = state.address;

    final style = TextStyle(
      color: address.tag != Tag.none
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).disabledColor,
      fontWeight: FontWeight.bold,
    );
    final addressWidth = SizeConfig.screenWidth * 0.7;
    final height = SizeConfig.screenHeight * 0.09;

    return SizedBox(
      // color: Colors.amber,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.saveAddressYourLocation),
          Row(
            children: [
              if (isLoading) ...[
                const Spacer(),
                const Center(child: CircularProgressIndicator()),
                const Spacer(),
              ] else ...[
                AddressWidget(
                  width: addressWidth,
                  address: address.address.streetName,
                  showExpand: false,
                ),
                const Spacer(),
                InkWell(
                  onTap: address.tag != Tag.none
                      ? () => _goToMyaddres(context)
                      : null,
                  child: Text(l10n.saveAddressChange, style: style),
                ),
              ]
            ],
          )
        ],
      ),
    );
  }
}

class _BuildTagLocation extends StatelessWidget {
  _BuildTagLocation({
    Key? key,
    required this.l10n,
    // required this.address,
  }) : super(key: key);

  final AppLocalizations l10n;
  // final DeliveryAddress address;

  final height = SizeConfig.screenHeight * 0.12;
  final buttonWidth = SizeConfig.screenWidth * 0.23;

  late final DeliveryAddress address;

  void _updateIndex(BuildContext context, Tag tag) {
    // widget.updateTag(tag);
    context.read<DeliveryAddressBloc>().add(DeliveryAdrressRequested(tag));
  }

  Widget _button(BuildContext context, String text, Tag tag) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: buttonWidth),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: address.tag.index == tag.index
              ? Theme.of(context).colorScheme.secondary
              : Colors.grey,
        ),
        onPressed: () => _updateIndex(context, tag),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    address = context.select((DeliveryAddressBloc b) => b.state.address);

    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(l10n.saveAddressTag),
          Row(
            children: [
              _button(context, l10n.saveAddressHome, Tag.home),
              const Spacer(),
              _button(context, l10n.saveAddressWork, Tag.work),
              const Spacer(),
              _button(context, l10n.saveAddressOther, Tag.other),
            ],
          )
        ],
      ),
    );
  }
}
