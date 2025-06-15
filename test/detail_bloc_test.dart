import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:pawfect_match/core/db/hive_boxes_keys.dart';
import 'package:pawfect_match/core/db/hive_pet_model.dart';
import 'package:pawfect_match/features/home/presentation/bloc/home_bloc.dart';
import 'package:pawfect_match/features/shared_models/pet_model.dart';

void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;
    late Box<HivePetModel> petsBox;

    final mockPet = PetModel(
      id: 1,
      name: 'Buddy',
      description: 'Friendly dog',
      imagePath: 'https://example.com/image.jpg',
      age: '2',
      breed: 'Labrador',
      gender: 'Male',
      cost: 100,
      isAdopted: false,
      type: 'Dog',
      size: 'small',
      isFavourite: false,
    );

    setUpAll(() async {
      final testDir = Directory.systemTemp.createTempSync();
      Hive.init(testDir.path);

      Hive.registerAdapter(HivePetModelAdapter());
      petsBox = await Hive.openBox<HivePetModel>(HiveBoxesKeys.petBox);
    });

    tearDownAll(() async {
      await Hive.deleteBoxFromDisk(HiveBoxesKeys.petBox);
      await Hive.close();
    });

    setUp(() async {
      await petsBox.clear();
      await petsBox.add(HivePetModel.fromPet(mockPet));
      homeBloc = HomeBloc();
    });

    tearDown(() async {
      await homeBloc.close();
    });

    blocTest<HomeBloc, HomeState>(
      'emits [PetListLoaded] when ToggleFavouritePet is added after loading',
      build: () => homeBloc,
      act: (bloc) async {
        bloc.add(PetListRequest());
        await Future.delayed(Duration(milliseconds: 100));
        bloc.add(ToggleFavouritePet(petModel: mockPet));
      },
      expect: () => [
        isA<PetListLoaded>()
      ],
    );
  });
}
