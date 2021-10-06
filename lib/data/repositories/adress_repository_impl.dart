import 'package:app_delivery_3/config/app_constants.dart';
import 'package:app_delivery_3/config/network_helper.dart';
import 'package:app_delivery_3/data/datasources/adress_data_source.dart';
import 'package:app_delivery_3/data/models/address_model.dart';
import 'package:app_delivery_3/domain/entities/address/address.dart';
import 'package:app_delivery_3/domain/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  AddressRepositoryImpl(this.dataSource);

  final AddressDataSource dataSource;

  @override
  Future<Address> getAddressFromPoint({
    required double lat,
    required double long,
  }) async {
    final endLat = lat;
    final endLon = long + AppConstants.orsOffsetDirection;
    final json = <String, dynamic>{
      'latitude': lat,
      'longitude': long,
    };

    try {
      final data = await dataSource.getAddress(
        startLat: lat,
        startLon: long,
        endLat: endLat,
        endLon: endLon,
      );

      json['name'] =
          data['features'][0]['properties']['segments'][0]['steps'][0]['name'];

      return AddressModel.fromJson(json);
    } on NetWorkException {
      // final body = e;

      json['name'] = '';
      return AddressModel.fromJson(json);
    }
  }
}
