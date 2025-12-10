import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_local_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addFavorite(String plantId) async {
    return await localDataSource.addFavorite(plantId);
  }

  @override
  Future<List<String>> getFavorites() async {
    return await localDataSource.getFavorites();
  }

  @override
  Future<bool> isFavorite(String plantId) async {
    return await localDataSource.isFavorite(plantId);
  }

  @override
  Future<void> removeFavorite(String plantId) async {
    return await localDataSource.removeFavorite(plantId);
  }
}
