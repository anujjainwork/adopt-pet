part of 'history_cubit.dart';

@immutable
sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

final class AdoptedListsLoaded extends HistoryState {
  final List<PetModel> petlists;

  AdoptedListsLoaded({required this.petlists});
}

final class EmptyAdoptedListLoaded extends HistoryState {}