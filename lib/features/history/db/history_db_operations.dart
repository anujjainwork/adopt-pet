import 'package:hive/hive.dart';
import 'package:pawfect_match/core/db/hive_boxes_keys.dart';
import 'package:pawfect_match/core/db/hive_pet_model.dart';
import 'package:pawfect_match/features/shared_models/pet_model.dart';

class HistoryDbOperations {
  static Future<List<PetModel>> fetchAllAdoptedPets() async {
    final box = await Hive.openBox<HivePetModel>(HiveBoxesKeys.petBox);

    List<HivePetModel> hivePets =
        box.values
            .where(
              (pet) => pet.isAdopted == true && pet.adoptedDateTime != null,
            )
            .toList();

    hivePets.sort((a, b) => b.adoptedDateTime!.compareTo(a.adoptedDateTime!));

    final petModels = hivePets.map((pet) => pet.toPetModel()).toList();

    return petModels;
  }
}
