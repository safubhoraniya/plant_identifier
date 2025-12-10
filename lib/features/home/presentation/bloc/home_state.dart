part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomePlantsLoaded extends HomeState {
  final List<Plant> plants;

  const HomePlantsLoaded(this.plants);

  @override
  List<Object> get props => [plants];
}

class HomeSearchLoaded extends HomeState {
  final List<Plant> plants;
  final String query;

  const HomeSearchLoaded(this.plants, this.query);

  @override
  List<Object> get props => [plants, query];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
