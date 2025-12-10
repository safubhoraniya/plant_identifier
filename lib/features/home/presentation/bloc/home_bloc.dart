import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/plant.dart';
import '../../../../domain/usecases/plant_usecases.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllPlantsUseCase getAllPlantsUseCase;
  final SearchPlantsUseCase searchPlantsUseCase;

  HomeBloc({
    required this.getAllPlantsUseCase,
    required this.searchPlantsUseCase,
  }) : super(const HomeInitial()) {
    on<FetchPlantsEvent>(_onFetchPlants);
    on<SearchPlantsEvent>(_onSearchPlants);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onFetchPlants(
    FetchPlantsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      final plants = await getAllPlantsUseCase();
      emit(HomePlantsLoaded(plants));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onSearchPlants(
    SearchPlantsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      final plants = await searchPlantsUseCase(event.query);
      emit(HomeSearchLoaded(plants, event.query));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onClearSearch(
    ClearSearchEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      final plants = await getAllPlantsUseCase();
      emit(HomePlantsLoaded(plants));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
