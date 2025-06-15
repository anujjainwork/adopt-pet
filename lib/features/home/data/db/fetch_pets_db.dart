import 'package:hive/hive.dart';
import 'package:pawfect_match/core/db/hive_boxes_keys.dart';
import 'package:pawfect_match/core/db/hive_pet_model.dart';
import 'package:pawfect_match/features/shared_models/pet_model.dart';

Future<List<PetModel>> fetchPetsFromDb({String? name}) async {
  final box = await Hive.openBox<HivePetModel>(HiveBoxesKeys.petBox);

  List<HivePetModel> hivePets = box.values.toList();

  if (name != null && name.trim().isNotEmpty) {
    final lowerName = name.toLowerCase();
    hivePets =
        hivePets
            .where((pet) => pet.name.toLowerCase().startsWith(lowerName))
            .toList();
  }

  final petModels = hivePets.map((pet) => pet.toPetModel()).toList();

  return petModels;
}
