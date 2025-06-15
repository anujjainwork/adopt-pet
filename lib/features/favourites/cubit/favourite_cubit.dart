import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pawfect_match/features/favourites/db/favourites_db_operations.dart';
import 'package:pawfect_match/features/shared_models/pet_model.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());


  Future<void> loadAllFavouritePets() async {
    final favouritePets = await FavouritesDbOperations.fetchAllFavouritePets();
    if(favouritePets.isNotEmpty){
      emit(FavouritePetsLoaded(favouritePets: favouritePets));
    } else {
      emit(EmptyFavouritePetsLoaded());
    }
  }
}
