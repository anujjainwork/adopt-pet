import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pawfect_match/features/home/data/db/fetch_pets_db.dart';
import 'package:pawfect_match/features/home/data/db/pets_db_operations.dart';
import 'package:pawfect_match/features/home/data/remote/fetch_pets_api.dart';
import 'package:pawfect_match/features/shared_models/pet_model.dart';

part 'home_event.dart';
part 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  String? searchQuery;
  int page = 0;
  HomeBloc() : super(HomeInitial()) {
    on<PetListRequest>(_onPetListRequest);
    on<SearchBoxQueryChanged>(_handleSearchBoxQueryChanged);
    on<SearchBoxLoadMore>(_handleSearchBoxLoadMore);
    on<ToggleFavouritePet>(_handleFavouritePet);
    on<PetListRefreshRequest>(_handlePetListRefresh);
    on<PetListNextPageRequest>(_handlePetListNewPageRequest);
  }

  Future<void> _onPetListRequest(
    PetListRequest event,
    Emitter<HomeState> emit,
  ) async {
    var petList = await fetchPetsFromDb();
    if (petList.isEmpty) {
      petList = await fetchPetsApi();
    }
    if (petList.isNotEmpty) {
      emit(PetListLoaded(petlists: petList));
    }
  }

  Future<void> _handleSearchBoxQueryChanged(
    SearchBoxQueryChanged event,
    Emitter<HomeState> emit,
  ) async {
    final petList = await fetchPetsFromDb(name: event.query);
    searchQuery = event.query;
    emit(PetListLoaded(petlists: petList));
    emit(SearchFilterFromDB(petlists: petList));
  }

  Future<void> _handleSearchBoxLoadMore(
    SearchBoxLoadMore event,
    Emitter<HomeState> emit,
  ) async {
    final petList = await fetchPetsApi(name: searchQuery);
    if (petList.isNotEmpty) {
      emit(PetListLoaded(petlists: petList));
    }
    onError(error, stackTrace){
      emit(PetListLoadingError());
    }
  }

  Future<void> _handleFavouritePet(
    ToggleFavouritePet event,
    Emitter<HomeState> emit,
  ) async {
    final toggleStatus = await PetsDbOperations.toggleFavouriteStatus(
      event.petModel,
    );
    if (toggleStatus) {
      final petList = await fetchPetsFromDb(name: searchQuery);
      emit(PetListLoaded(petlists: petList));
    }
    onError(error, stackTrace){
      emit(PetListLoadingError());
    }
  }

  Future<void> _handlePetListRefresh(
    PetListRefreshRequest event,
    Emitter<HomeState> emit,
  ) async {
    await fetchPetsApi();
    final petList = await fetchPetsFromDb();
    if (petList.isNotEmpty) {
      emit(PetListLoaded(petlists: petList));
    }
    onError(error, stackTrace){
      emit(PetListLoadingError());
    }
  }

  Future<void> _handlePetListNewPageRequest(
    PetListNextPageRequest event,
    Emitter<HomeState> emit,
  ) async {
    await fetchPetsApi(page: page+1);
    final petList = await fetchPetsFromDb();
    if (petList.isNotEmpty) {
      emit(PetListLoaded(petlists: petList));
      page = page + 1;
    }
    onError(error, stackTrace){
      emit(PetListLoadingError());
    }
  }
}
