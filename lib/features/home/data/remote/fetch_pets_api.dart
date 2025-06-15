import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:pawfect_match/core/db/hive_boxes_keys.dart';
import 'package:pawfect_match/core/db/hive_pet_model.dart';
import 'package:pawfect_match/features/shared_models/pet_model.dart';
import 'package:pawfect_match/utils/api_key.dart';

Future<List<PetModel>> fetchPetsApi({String? name, int? page}) async {
  final queryParams = {
    if (name != null && name.trim().isNotEmpty) 'name': name.trim(),
    if (page != null) 'page' : page.toString()
  };

  final uri = Uri.https('api.petfinder.com', '/v2/animals', queryParams);

  final accessToken = await fetchPetfinderToken();

  try {
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> animals = data['animals'];

      final List<PetModel> pets =
          animals.map((animal) {
            final int id = animal['id'];
            final String name = animal['name'] ?? 'Unknown';
            final String ageString = animal['age'] ?? 'Baby';
            final double price = 0.0;
            final List photos = animal['photos'];
            final String imagePath =
                photos.isNotEmpty ? photos[0]['medium'] : '';
            final String type = animal['type'] ?? 'unkown';
            final String size = animal['size'] ?? 'unkown';
            final String gender = animal['gender'] ?? 'unkown';
            final String description = '$name is an adorable $ageString $type. Please adopt $name';
            final String breed = animal['breed'] ?? 'unkown';

            return PetModel(
              id: id,
              name: name,
              age: ageString,
              cost: price,
              imagePath: imagePath,
              isAdopted: false,
              isFavourite: false,
              breed: breed,
              type: type,
              size: size,
              gender: gender,
              description: description,
            );
          }).toList();

      await saveToDB(pets);
      return pets;
    } else {
      throw Exception('Failed to fetch pets: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error fetching pets: $e');
    return [];
  }
}

Future<bool> saveToDB(List<PetModel> petModelList) async {
  try {
    final petsBox = await Hive.openBox<HivePetModel>(HiveBoxesKeys.petBox);

    for (var pet in petModelList) {
      // Check if pet with same ID exists
      final existing = petsBox.get(pet.id);

      if (existing == null) {
        // Save only if not already present
        await petsBox.put(pet.id, HivePetModel.fromPet(pet));
      }
    }

    await petsBox.close();
    return true;
  } catch (e, stackTrace) {
    debugPrint('Error saving to DB: $e at $stackTrace');
    return false;
  }
}
