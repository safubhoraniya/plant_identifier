part of 'plant_detail_bloc.dart';

abstract class PlantDetailState extends Equatable {
  const PlantDetailState();

  @override
  List<Object?> get props => [];
}

class PlantDetailInitial extends PlantDetailState {
  const PlantDetailInitial();
}

class PlantDetailLoading extends PlantDetailState {
  const PlantDetailLoading();
}

class PlantDetailLoaded extends PlantDetailState {
  final Plant plant;
  final bool isFavorite;

  const PlantDetailLoaded(this.plant, {this.isFavorite = false});

  @override
  List<Object?> get props => [plant, isFavorite];
}

class PlantDetailError extends PlantDetailState {
  final String message;

  const PlantDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
