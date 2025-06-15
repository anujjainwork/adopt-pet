import 'package:hive/hive.dart';
import 'package:pawfect_match/core/db/hive_boxes_keys.dart';
import 'package:pawfect_match/core/db/hive_pet_model.dart';
import 'package:pawfect_match/features/shared_models/pet_model.dart';

class FavouritesDbOperations {
  static Future<List<PetModel>> fetchAllFavouritePets () async {
    final box = await Hive.openBox<HivePetModel>(HiveBoxesKeys.petBox);

    List<HivePetModel> hivePets = box.values.toList();

    hivePets = hivePets.where((pet) => pet.isFavourite == true).toList();

    final petModels = hivePets.map((pet) => pet.toPetModel()).toList();

    return petModels;
  }
}