// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeding_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeedingModelAdapter extends TypeAdapter<FeedingModel> {
  @override
  final int typeId = 3;

  @override
  FeedingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeedingModel(
      id: fields[0] as String?,
      note: fields[1] as String?,
      time: fields[2] as DateTime?,
      amount: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, FeedingModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.note)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
