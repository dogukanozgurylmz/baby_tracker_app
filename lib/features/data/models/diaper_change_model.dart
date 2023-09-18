import 'package:hive/hive.dart';
part 'diaper_change_model.g.dart';

@HiveType(typeId: 4)
class DiaperChangeModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? diaperStatus;
  @HiveField(2)
  DateTime? time;

  DiaperChangeModel({
    required this.id,
    required this.diaperStatus,
    required this.time,
  });
}
