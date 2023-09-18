// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baby_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BabyModelAdapter extends TypeAdapter<BabyModel> {
  @override
  final int typeId = 1;

  @override
  BabyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BabyModel(
      id: fields[0] as String?,
      fullName: fields[1] as String?,
      birthDate: fields[2] as DateTime?,
      timeOfBirth: fields[3] as String?,
      dueDate: fields[4] as String?,
      image: fields[5] as Uint8List?,
      gender: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BabyModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.birthDate)
      ..writeByte(3)
      ..write(obj.timeOfBirth)
      ..writeByte(4)
      ..write(obj.dueDate)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BabyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
