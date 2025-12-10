import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/plant.dart';
import '../../../../domain/usecases/plant_usecases.dart';
import '../../../../domain/usecases/favorites_usecases.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final GetAllPlantsUseCase getAllPlantsUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;

  FavoritesBloc({
    required this.getFavoritesUseCase,
    required this.getAllPlantsUseCase,
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
  }) : super(const FavoritesInitial()) {
    on<FetchFavoritesEvent>(_onFetchFavorites);
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
  }

  Future<void> _onFetchFavorites(
    FetchFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoading());
    try {
      final favoriteIds = await getFavoritesUseCase();
      final allPlants = await getAllPlantsUseCase();
      final favoritePlants = allPlants
          .where((plant) => favoriteIds.contains(plant.id))
          .toList();

      if (favoritePlants.isEmpty) {
        emit(const FavoritesEmpty());
      } else {
        emit(FavoritesLoaded(favoritePlants));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onAddFavorite(
    AddFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await addFavoriteUseCase(event.plantId);
      add(const FetchFavoritesEvent());
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onRemoveFavorite(
    RemoveFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await removeFavoriteUseCase(event.plantId);
      add(const FetchFavoritesEvent());
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
