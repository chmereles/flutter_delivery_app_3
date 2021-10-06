part of 'delivery_address_bloc.dart';

enum DeliveryAddressStatus { unavailable, available, pending, loading }

class DeliveryAddressState extends Equatable {
  DeliveryAddressState(
      {DeliveryAddress? address, DeliveryAddressStatus? status}) {
    this.address = address ?? DeliveryAddressModel.zero();
    this.status = status ?? DeliveryAddressStatus.pending;
  }

  factory DeliveryAddressState.pending(DeliveryAddress address) {
    return DeliveryAddressState(
      status: DeliveryAddressStatus.pending,
      address: address,
    );
  }

  factory DeliveryAddressState.loading(DeliveryAddress address) {
    return DeliveryAddressState(
      status: DeliveryAddressStatus.loading,
      address: address,
    );
  }

  factory DeliveryAddressState.available({required DeliveryAddress address}) {
    return DeliveryAddressState(
      status: DeliveryAddressStatus.available,
      address: address,
    );
  }

  factory DeliveryAddressState.unavailable(DeliveryAddress address) {
    return DeliveryAddressState(
      status: DeliveryAddressStatus.unavailable,
      address: address,
    );
  }

  late final DeliveryAddress address;
  late final DeliveryAddressStatus status;

  @override
  List<Object> get props => [address];
}
