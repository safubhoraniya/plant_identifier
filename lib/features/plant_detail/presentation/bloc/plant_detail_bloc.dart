import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/plant.dart';
import '../../../../domain/usecases/plant_usecases.dart';
import '../../../../domain/usecases/favorites_usecases.dart';

part 'plant_detail_event.dart';
part 'plant_detail_state.dart';

class PlantDetailBloc extends Bloc<PlantDetailEvent, PlantDetailState> {
  final GetPlantByIdUseCase getPlantByIdUseCase;
  final IsFavoriteUseCase isFavoriteUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;

  PlantDetailBloc({
    required this.getPlantByIdUseCase,
    required this.isFavoriteUseCase,
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
  }) : super(const PlantDetailInitial()) {
    on<FetchPlantDetailsEvent>(_onFetchPlantDetails);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onFetchPlantDetails(
    FetchPlantDetailsEvent event,
    Emitter<PlantDetailState> emit,
  ) async {
    emit(const PlantDetailLoading());
    try {
      final plant = await getPlantByIdUseCase(event.plantId);
      if (plant != null) {
        final isFavorite = await isFavoriteUseCase(plant.id);
        emit(PlantDetailLoaded(plant, isFavorite: isFavorite));
      } else {
        emit(const PlantDetailError('Plant not found'));
      }
    } catch (e) {
      emit(PlantDetailError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<PlantDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is PlantDetailLoaded) {
      try {
        if (currentState.isFavorite) {
          await removeFavoriteUseCase(event.plantId);
        } else {
          await addFavoriteUseCase(event.plantId);
        }
        emit(PlantDetailLoaded(
          currentState.plant,
          isFavorite: !currentState.isFavorite,
        ));
      } catch (e) {
        emit(PlantDetailError(e.toString()));
      }
    }
  }
}
