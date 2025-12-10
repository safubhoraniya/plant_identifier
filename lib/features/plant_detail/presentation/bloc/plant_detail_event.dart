part of 'plant_detail_bloc.dart';

abstract class PlantDetailEvent extends Equatable {
  const PlantDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchPlantDetailsEvent extends PlantDetailEvent {
  final String plantId;

  const FetchPlantDetailsEvent(this.plantId);

  @override
  List<Object> get props => [plantId];
}

class ToggleFavoriteEvent extends PlantDetailEvent {
  final String plantId;

  const ToggleFavoriteEvent(this.plantId);

  @override
  List<Object> get props => [plantId];
}
