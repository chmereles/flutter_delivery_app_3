import 'package:app_delivery_3/domain/entities/address/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel extends Address {
  AddressModel({
    required this.streetName,
    required this.latitude,
    required this.longitude,
  }) : super(
          streetName: streetName,
          latitude: latitude,
          longitude: longitude,
        );

  factory AddressModel.zero() {
    return AddressModel(
      latitude: 0,
      longitude: 0,
      streetName: '',
    );
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  @JsonKey(name: 'name')
  final String streetName;
  final double latitude;
  final double longitude;
}
