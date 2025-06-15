part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class PetListLoaded extends HomeState {
  final List<PetModel> petlists;
  PetListLoaded({required this.petlists});
}

final class PetListLoading extends HomeState {

}

final class SearchFilterFromDB extends PetListLoaded {
  SearchFilterFromDB({required super.petlists});
}

final class PetListLoadingError extends HomeState {}