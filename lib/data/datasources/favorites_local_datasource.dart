import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoritesLocalDataSource {
  Future<List<String>> getFavorites();
  Future<void> addFavorite(String plantId);
  Future<void> removeFavorite(String plantId);
  Future<bool> isFavorite(String plantId);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  static const String _favoritesKey = 'favorites';

  final SharedPreferences _sharedPreferences;

  FavoritesLocalDataSourceImpl({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  @override
  Future<List<String>> getFavorites() async {
    final favoritesJson = _sharedPreferences.getStringList(_favoritesKey) ?? [];
    return favoritesJson;
  }

  @override
  Future<void> addFavorite(String plantId) async {
    final favorites = await getFavorites();
    if (!favorites.contains(plantId)) {
      favorites.add(plantId);
      await _sharedPreferences.setStringList(_favoritesKey, favorites);
    }
  }

  @override
  Future<void> removeFavorite(String plantId) async {
    final favorites = await getFavorites();
    favorites.removeWhere((id) => id == plantId);
    await _sharedPreferences.setStringList(_favoritesKey, favorites);
  }

  @override
  Future<bool> isFavorite(String plantId) async {
    final favorites = await getFavorites();
    return favorites.contains(plantId);
  }
}
