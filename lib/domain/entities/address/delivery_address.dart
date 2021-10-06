import 'package:app_delivery_3/domain/entities/address/address.dart';

enum Tag { home, work, other, none }

class DeliveryAddress {
  DeliveryAddress({required this.address, required this.tag});

  final Address address;
  final Tag tag;

  DeliveryAddress copyWith({
    Address? address,
    Tag? tag,
  }) {
    return DeliveryAddress(
      address: address ?? this.address,
      tag: tag ?? this.tag,
    );
  }
}
