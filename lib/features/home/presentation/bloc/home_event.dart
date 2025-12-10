part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchPlantsEvent extends HomeEvent {
  const FetchPlantsEvent();
}

class SearchPlantsEvent extends HomeEvent {
  final String query;

  const SearchPlantsEvent(this.query);

  @override
  List<Object> get props => [query];
}

class ClearSearchEvent extends HomeEvent {
  const ClearSearchEvent();
}
