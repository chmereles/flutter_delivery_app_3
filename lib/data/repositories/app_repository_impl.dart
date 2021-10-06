import 'package:app_delivery_3/data/datasources/app_data_source.dart';
import 'package:app_delivery_3/data/models/address_model.dart';
import 'package:app_delivery_3/data/models/delivery_address_model.dart';
import 'package:app_delivery_3/domain/entities/address/address.dart';
import 'package:app_delivery_3/domain/entities/address/delivery_address.dart';
import 'package:app_delivery_3/domain/repositories/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  AppRepositoryImpl({required this.dataSource});

  final AppDataSource dataSource;
  @override
  Future<DeliveryAddress> getDeliveryLocation(Tag tag) async {
    final Map<String, dynamic>? data;
    switch (tag) {
      case Tag.work:
        data = await dataSource.getWorkDeliveryAddress();
        break;
      case Tag.other:
        data = await dataSource.getOtherDeliveryAddress();
        break;

      default:
        data = await dataSource.getHomeDeliveryAddress();
    }

    if (data != null) {
      return DeliveryAddressModel.fromJson(data);
    }
    return DeliveryAddressModel.zero();
  }

  @override
  Future<DeliveryAddress> saveDeliveryLocation({
    required String streetName,
    required double lat,
    required double lon,
    required Tag tag,
  }) async {
    final address = AddressModel(
      streetName: streetName,
      latitude: lat,
      longitude: lon,
    );
    final deliveryAddress = DeliveryAddressModel(address: address, tag: tag);
    await dataSource.saveDeliveryAddress(
      address: deliveryAddress.toRawJson(),
      tagString: deliveryAddress.tag.toString(),
    );
    return deliveryAddress;
  }
}
