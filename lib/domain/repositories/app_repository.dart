import 'package:app_delivery_3/domain/entities/address/delivery_address.dart';

abstract class AppRepository {
  Future<DeliveryAddress> saveDeliveryLocation({
    required String streetName,
    required double lat,
    required double lon,
    required Tag tag,
  });
  Future<DeliveryAddress> getDeliveryLocation(Tag tag);
}
