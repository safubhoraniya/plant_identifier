abstract class FavoritesRepository {
  Future<List<String>> getFavorites();
  Future<void> addFavorite(String plantId);
  Future<void> removeFavorite(String plantId);
  Future<bool> isFavorite(String plantId);
}
