import 'package:app_delivery_3/domain/entities/address/address.dart';

abstract class AddressRepository {
  // obtener la direccion, del punto pasado como parametro
  Future<Address> getAddressFromPoint({
    required double lat,
    required double long,
  });
}
