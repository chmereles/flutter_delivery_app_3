part of 'main_bloc.dart';

enum Status { initial, selectedTab, selectedTabWithProduct }

@immutable
class MainState extends Equatable {
  const MainState({
    required this.tabIndex,
    this.productId = -1,
    this.status = Status.initial,
  });

  factory MainState.initial() {
    return const MainState(tabIndex: 0);
  }

  factory MainState.selectedTab(int tabIndex) {
    return MainState(tabIndex: tabIndex, status: Status.selectedTab);
  }

  factory MainState.selectedTabWithProduct(int tab, int id) {
    return MainState(
        tabIndex: tab, productId: id, status: Status.selectedTabWithProduct);
  }

  final int tabIndex;
  final int productId;
  final Status status;

  @override
  List<Object?> get props => [tabIndex, productId];
}
