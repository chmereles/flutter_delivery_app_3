import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState.initial()) {
    on<SelectedTab>(
      (event, emit) => emit(
        MainState.selectedTab(
          event.index,
        ),
      ),
    );
    on<SelectedTabWithProduct>(
      (event, emit) => emit(
        MainState.selectedTabWithProduct(
          event.index,
          event.productId,
        ),
      ),
    );
  }
}
