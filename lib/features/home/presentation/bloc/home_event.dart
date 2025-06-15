part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class PetListRequest extends HomeEvent {}

final class SearchBoxQueryChanged extends HomeEvent {
  final String query;
  SearchBoxQueryChanged({required this.query});
}

final class SearchBoxLoadMore extends HomeEvent {
  SearchBoxLoadMore();
}

final class ToggleFavouritePet extends HomeEvent {
  final PetModel petModel;
  ToggleFavouritePet({required this.petModel});
}

final class PetListRefreshRequest extends HomeEvent {}

final class PetListNextPageRequest extends HomeEvent {}
