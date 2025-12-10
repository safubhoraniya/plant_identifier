import '../repositories/favorites_repository.dart';

class GetFavoritesUseCase {
  final FavoritesRepository repository;

  GetFavoritesUseCase({required this.repository});

  Future<List<String>> call() async {
    return await repository.getFavorites();
  }
}

class AddFavoriteUseCase {
  final FavoritesRepository repository;

  AddFavoriteUseCase({required this.repository});

  Future<void> call(String plantId) async {
    return await repository.addFavorite(plantId);
  }
}

class RemoveFavoriteUseCase {
  final FavoritesRepository repository;

  RemoveFavoriteUseCase({required this.repository});

  Future<void> call(String plantId) async {
    return await repository.removeFavorite(plantId);
  }
}

class IsFavoriteUseCase {
  final FavoritesRepository repository;

  IsFavoriteUseCase({required this.repository});

  Future<bool> call(String plantId) async {
    return await repository.isFavorite(plantId);
  }
}
