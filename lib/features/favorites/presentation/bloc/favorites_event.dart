part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FetchFavoritesEvent extends FavoritesEvent {
  const FetchFavoritesEvent();
}

class AddFavoriteEvent extends FavoritesEvent {
  final String plantId;

  const AddFavoriteEvent(this.plantId);

  @override
  List<Object> get props => [plantId];
}

class RemoveFavoriteEvent extends FavoritesEvent {
  final String plantId;

  const RemoveFavoriteEvent(this.plantId);

  @override
  List<Object> get props => [plantId];
}
