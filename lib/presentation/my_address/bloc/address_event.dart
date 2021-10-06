part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class AddressSolicited extends AddressEvent {
  const AddressSolicited({required this.point});

  final LatLng point;
  @override
  List<Object> get props => [point];
}
