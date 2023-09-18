// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SleepModelAdapter extends TypeAdapter<SleepModel> {
  @override
  final int typeId = 5;

  @override
  SleepModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SleepModel(
      id: fields[0] as String?,
      wakeUp: fields[1] as DateTime?,
      fellSleep: fields[2] as DateTime?,
      note: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SleepModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.wakeUp)
      ..writeByte(2)
      ..write(obj.fellSleep)
      ..writeByte(3)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
