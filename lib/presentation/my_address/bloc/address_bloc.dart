import 'package:app_delivery_3/domain/entities/address/address.dart';
import 'package:app_delivery_3/domain/repositories/address_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc(this.repository) : super(AddressInitial()) {
    on<AddressSolicited>(_onEventSolicited);
  }

  final AddressRepository repository;

  Future<void> _onEventSolicited(
    AddressSolicited event,
    Emitter<AddressState> emit,
  ) async {
    final address = await repository.getAddressFromPoint(
      lat: event.point.latitude,
      long: event.point.longitude,
    );

    print('adress: $address');
    emit(AddressLoaded(address: address));
  }
}
