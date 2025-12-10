import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/plant.dart';
import '../../../../domain/usecases/plant_usecases.dart';

part 'plant_list_event.dart';
part 'plant_list_state.dart';

class PlantListBloc extends Bloc<PlantListEvent, PlantListState> {
  final GetAllPlantsUseCase getAllPlantsUseCase;

  PlantListBloc({required this.getAllPlantsUseCase})
      : super(const PlantListInitial()) {
    on<FetchPlantsByCareLevelEvent>(_onFetchByCategory);
  }

  Future<void> _onFetchByCategory(
    FetchPlantsByCareLevelEvent event,
    Emitter<PlantListState> emit,
  ) async {
    emit(const PlantListLoading());
    try {
      final allPlants = await getAllPlantsUseCase();
      final filtered = allPlants
          .where((plant) => plant.careLevel == event.careLevel)
          .toList();
      emit(PlantListLoaded(filtered));
    } catch (e) {
      emit(PlantListError(e.toString()));
    }
  }
}
