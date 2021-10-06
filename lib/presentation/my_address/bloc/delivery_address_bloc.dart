import 'package:app_delivery_3/data/models/delivery_address_model.dart';
import 'package:app_delivery_3/domain/entities/address/address.dart';
import 'package:app_delivery_3/domain/entities/address/delivery_address.dart';
import 'package:app_delivery_3/domain/repositories/app_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delivery_address_event.dart';
part 'delivery_address_state.dart';

class DeliveryAddressBloc
    extends Bloc<DeliveryAddressEvent, DeliveryAddressState> {
  DeliveryAddressBloc(this.repository) : super(DeliveryAddressState()) {
    on<DeliveryAdrressInitRequested>(_onInit);
    on<DeliveryAdrressRequested>(_onRequested);
    on<DeliveryAdrressSaved>(_onSaved);
    on<DeliveryAdrressChanged>(_onChanged);
  }
  final AppRepository repository;

  Future<void> _onSaved(
    DeliveryAdrressSaved event,
    Emitter<DeliveryAddressState> emit,
  ) async {
    //
    emit(DeliveryAddressState.pending(state.address.copyWith()));

    try {
      // final tag = event.tag;
      final deliveryAddress = await repository.saveDeliveryLocation(
          streetName: event.address.address.streetName,
          lat: event.address.address.latitude,
          lon: event.address.address.longitude,
          tag: event.address.tag);
      emit(DeliveryAddressState.available(address: deliveryAddress));
    } catch (e) {
      print(e);
      emit(DeliveryAddressState.unavailable(state.address.copyWith()));
    }
  }

  Future<void> _onInit(
    DeliveryAdrressInitRequested event,
    Emitter<DeliveryAddressState> emit,
  ) async {
    emit(DeliveryAddressState.pending(state.address.copyWith()));

    try {
      final deliveryAddress = await repository.getDeliveryLocation(Tag.none);
      emit(
        DeliveryAddressState.available(
          address: deliveryAddress.copyWith(),
        ),
      );
    } catch (e) {
      print(e);
      emit(DeliveryAddressState.unavailable(state.address.copyWith()));
    }
  }

  Future<void> _onRequested(
    DeliveryAdrressRequested event,
    Emitter<DeliveryAddressState> emit,
  ) async {
    emit(DeliveryAddressState.loading(state.address.copyWith()));

    try {
      final tag = event.tag;
      final deliveryAddress = await repository.getDeliveryLocation(tag);
      emit(
        DeliveryAddressState.available(
          address: deliveryAddress.copyWith(tag: tag),
        ),
      );
    } catch (e) {
      print(e);
      emit(DeliveryAddressState.unavailable(state.address.copyWith()));
    }
  }

  Future<void> _onChanged(
    DeliveryAdrressChanged event,
    Emitter<DeliveryAddressState> emit,
  ) async {
    emit(DeliveryAddressState.pending(state.address.copyWith()));

    try {
      final deliveryAddress = state.address.copyWith(
        address: event.address,
      );
      emit(DeliveryAddressState.available(address: deliveryAddress));
    } catch (e) {
      print(e);
      emit(DeliveryAddressState.unavailable(state.address.copyWith()));
    }
  }
}
