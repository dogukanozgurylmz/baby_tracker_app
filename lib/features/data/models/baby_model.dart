import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'baby_model.g.dart';

@HiveType(typeId: 1)
class BabyModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? fullName;
  @HiveField(2)
  DateTime? birthDate;
  @HiveField(3)
  String? timeOfBirth;
  @HiveField(4)
  String? dueDate;
  @HiveField(5)
  Uint8List? image;
  @HiveField(6)
  String? gender;

  BabyModel({
    required this.id,
    required this.fullName,
    required this.birthDate,
    required this.timeOfBirth,
    required this.dueDate,
    required this.image,
    required this.gender,
  });
}
