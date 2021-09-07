import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState.initial());

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if (event is SelectedTab) {
      yield MainState.selectedTab(event.index);
    }
    //
    else if (event is SelectedTabWithProduct) {
      yield MainState.selectedTabWithProduct(event.index, event.productId);
    }
  }
}
