part of 'plant_list_bloc.dart';

abstract class PlantListEvent extends Equatable {
  const PlantListEvent();

  @override
  List<Object> get props => [];
}

class FetchPlantsByCareLevelEvent extends PlantListEvent {
  final String careLevel;

  const FetchPlantsByCareLevelEvent(this.careLevel);

  @override
  List<Object> get props => [careLevel];
}
