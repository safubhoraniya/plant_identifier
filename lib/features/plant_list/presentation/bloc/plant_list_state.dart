part of 'plant_list_bloc.dart';

abstract class PlantListState extends Equatable {
  const PlantListState();

  @override
  List<Object> get props => [];
}

class PlantListInitial extends PlantListState {
  const PlantListInitial();
}

class PlantListLoading extends PlantListState {
  const PlantListLoading();
}

class PlantListLoaded extends PlantListState {
  final List<Plant> plants;

  const PlantListLoaded(this.plants);

  @override
  List<Object> get props => [plants];
}

class PlantListError extends PlantListState {
  final String message;

  const PlantListError(this.message);

  @override
  List<Object> get props => [message];
}
