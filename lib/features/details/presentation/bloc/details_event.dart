part of 'details_bloc.dart';

@immutable
sealed class DetailsEvent {}

class AdoptPet extends DetailsEvent {
  final PetModel petModel;
  AdoptPet({required this.petModel});
}

class InitialDetailsEvent extends DetailsEvent{}
