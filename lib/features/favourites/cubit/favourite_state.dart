part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

final class FavouritePetsLoaded extends FavouriteState {
  final List<PetModel> favouritePets;

  FavouritePetsLoaded({required this.favouritePets});
}

final class EmptyFavouritePetsLoaded extends FavouriteState {}
