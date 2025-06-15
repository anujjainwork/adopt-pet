import 'package:hive_flutter/hive_flutter.dart';
import 'package:pawfect_match/core/db/hive_pet_model.dart';

void hiveInitialise() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HivePetModelAdapter());
}
