import 'package:hive/hive.dart';
part 'feeding_model.g.dart';

@HiveType(typeId: 3)
class FeedingModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? note;
  @HiveField(2)
  DateTime? time;
  @HiveField(3)
  int? amount;
  FeedingModel({
    required this.id,
    required this.note,
    required this.time,
    required this.amount,
  });
}
