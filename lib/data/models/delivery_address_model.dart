import 'dart:convert';

import 'package:app_delivery_3/data/models/address_model.dart';
import 'package:app_delivery_3/domain/entities/address/delivery_address.dart';

import 'package:json_annotation/json_annotation.dart';

part 'delivery_address_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DeliveryAddressModel extends DeliveryAddress {
  DeliveryAddressModel({
    required this.address,
    required this.tag,
  }) : super(address: address, tag: tag);

  factory DeliveryAddressModel.zero() {
    return DeliveryAddressModel(
      address: AddressModel.zero(),
      tag: Tag.none,
    );
  }

  factory DeliveryAddressModel.fromRawJson(String str) =>
      DeliveryAddressModel.fromJson(json.decode(str) as Map<String, dynamic>);

  factory DeliveryAddressModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryAddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryAddressModelToJson(this);

  final AddressModel address;
  final Tag tag;

  String toRawJson() => json.encode(toJson());
}
