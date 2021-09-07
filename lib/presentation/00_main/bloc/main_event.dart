part of 'main_bloc.dart';

@immutable
abstract class MainEvent extends Equatable {}

class SelectedTab extends MainEvent {
  SelectedTab(this.index);
  final int index;

  @override
  List<Object> get props => [index];
}

class SelectedTabWithProduct extends MainEvent {
  SelectedTabWithProduct({
    required this.index,
    required this.productId,
  });

  final int index;
  final int productId;

  @override
  List<Object> get props => [index, productId];
}
