// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_pet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePetModelAdapter extends TypeAdapter<HivePetModel> {
  @override
  final int typeId = 0;

  @override
  HivePetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePetModel(
      id: fields[0] as int,
      name: fields[1] as String,
      age: fields[2] as String,
      type: fields[3] as String,
      size: fields[4] as String,
      gender: fields[5] as String,
      breed: fields[6] as String,
      description: fields[7] as String,
      cost: fields[8] as double,
      imagePath: fields[9] as String,
      isAdopted: fields[10] as bool,
      isFavourite: fields[11] as bool,
      adoptedDateTime: fields[12] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, HivePetModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.size)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.breed)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.cost)
      ..writeByte(9)
      ..write(obj.imagePath)
      ..writeByte(10)
      ..write(obj.isAdopted)
      ..writeByte(11)
      ..write(obj.isFavourite)
      ..writeByte(12)
      ..write(obj.adoptedDateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivePetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
