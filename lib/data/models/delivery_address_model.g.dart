// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryAddressModel _$DeliveryAddressModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryAddressModel(
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      tag: _$enumDecode(_$TagEnumMap, json['tag']),
    );

Map<String, dynamic> _$DeliveryAddressModelToJson(
        DeliveryAddressModel instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'tag': _$TagEnumMap[instance.tag],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$TagEnumMap = {
  Tag.home: 'home',
  Tag.work: 'work',
  Tag.other: 'other',
  Tag.none: 'none',
};
