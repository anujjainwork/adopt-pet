import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pawfect_match/features/details/data/details_db_operations.dart';
import 'package:pawfect_match/features/home/presentation/bloc/home_bloc.dart';
import 'package:pawfect_match/features/shared_models/pet_model.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final HomeBloc homeBloc;
  DetailsBloc(this.homeBloc) : super(DetailsInitial()) {
    on<AdoptPet>(_handleAdoptPet);
    on<InitialDetailsEvent>(_initialDetailsBloc);
  }


  Future<void> _handleAdoptPet(AdoptPet event,
    Emitter<DetailsState> emit) async {
      final adoptStatus = await DetailsDbOperations.adoptMeButton(event.petModel);
      if(adoptStatus){
        homeBloc.add(PetListRequest());
        emit(PetAdopted());
      }
  }

  Future<void> _initialDetailsBloc(InitialDetailsEvent event, Emitter<DetailsState> emit) async {
    emit(DetailsInitial());
  }
}
