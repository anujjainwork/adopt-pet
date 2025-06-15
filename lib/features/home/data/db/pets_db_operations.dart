import 'package:hive/hive.dart';
import 'package:pawfect_match/core/db/hive_boxes_keys.dart';
import 'package:pawfect_match/core/db/hive_pet_model.dart';
import 'package:pawfect_match/features/shared_models/pet_model.dart';

class PetsDbOperations {
  static Future<bool> toggleFavouriteStatus(PetModel petModel) async {
    try {
      final box = await Hive.openBox<HivePetModel>(HiveBoxesKeys.petBox);
      final favStatus = petModel.isFavourite;
      final updatedPet = petModel.copyWith(isFavourite: !favStatus);

      final hivePet = HivePetModel.fromPet(updatedPet);

      // Check if a pet with the same ID already exists
      final existingKey = box.keys.firstWhere(
        (key) => box.get(key)?.id == petModel.id,
        orElse: () => null,
      );

      if (existingKey != null) {
        // Update the existing record
        await box.put(existingKey, hivePet);
      } else {
        // Add new record
        await box.add(hivePet);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
