import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pawfect_match/features/history/db/history_db_operations.dart';
import 'package:pawfect_match/features/shared_models/pet_model.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  Future<void> loadAllAdoptedPets() async {
    final adoptedPets = await HistoryDbOperations.fetchAllAdoptedPets();
    if(adoptedPets.isNotEmpty){
      emit(AdoptedListsLoaded(petlists: adoptedPets));
    } else {
      emit(EmptyAdoptedListLoaded());
    }
  }
}
