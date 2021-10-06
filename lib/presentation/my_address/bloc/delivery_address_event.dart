part of 'delivery_address_bloc.dart';

abstract class DeliveryAddressEvent extends Equatable {
  const DeliveryAddressEvent();

  @override
  List<Object> get props => [];
}

class DeliveryAdrressSaved extends DeliveryAddressEvent {
  const DeliveryAdrressSaved({
    required this.address,
  });

  final DeliveryAddress address;

  @override
  List<Object> get props => [address];
}

class DeliveryAdrressRequested extends DeliveryAddressEvent {
  const DeliveryAdrressRequested(this.tag);

  final Tag tag;
}

class DeliveryAdrressInitRequested extends DeliveryAddressEvent {
  const DeliveryAdrressInitRequested();
}

class DeliveryAdrressChanged extends DeliveryAddressEvent {
  const DeliveryAdrressChanged({required this.address});

  final Address address;
}
