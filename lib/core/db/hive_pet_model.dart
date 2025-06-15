import 'package:hive/hive.dart';
import 'package:pawfect_match/features/shared_models/pet_model.dart';

part 'hive_pet_model.g.dart';

@HiveType(typeId: 0)
class HivePetModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String age;

  @HiveField(3)
  String type;

  @HiveField(4)
  String size;

  @HiveField(5)
  String gender;

  @HiveField(6)
  String breed;

  @HiveField(7)
  String description;

  @HiveField(8)
  double cost;

  @HiveField(9)
  String imagePath;

  @HiveField(10)
  bool isAdopted;

  @HiveField(11)
  bool isFavourite;

  @HiveField(12)
  DateTime? adoptedDateTime;

  HivePetModel({
    required this.id,
    required this.name,
    required this.age,
    required this.type,
    required this.size,
    required this.gender,
    required this.breed,
    required this.description,
    required this.cost,
    required this.imagePath,
    required this.isAdopted,
    required this.isFavourite,
    this.adoptedDateTime
  });

  factory HivePetModel.fromPet(PetModel pet) {
    return HivePetModel(
      id: pet.id,
      name: pet.name,
      age: pet.age,
      type: pet.type,
      size: pet.size,
      gender: pet.gender,
      breed: pet.breed,
      description: pet.description,
      cost: pet.cost,
      imagePath: pet.imagePath,
      isAdopted: pet.isAdopted,
      isFavourite: pet.isFavourite,
      adoptedDateTime: pet.adoptedDateTime
    );
  }

  PetModel toPetModel() {
    return PetModel(
      id: id,
      name: name,
      age: age,
      type: type,
      size: size,
      gender: gender,
      breed: breed,
      description: description,
      cost: cost,
      imagePath: imagePath,
      isAdopted: isAdopted,
      isFavourite: isFavourite,
      adoptedDateTime: adoptedDateTime
    );
  }
}