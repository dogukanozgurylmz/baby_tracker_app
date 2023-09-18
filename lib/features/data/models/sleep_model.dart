import 'package:hive/hive.dart';
part 'sleep_model.g.dart';

@HiveType(typeId: 5)
class SleepModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  DateTime? wakeUp;
  @HiveField(2)
  DateTime? fellSleep;
  @HiveField(3)
  String? note;
  SleepModel({
    required this.id,
    required this.wakeUp,
    required this.fellSleep,
    required this.note,
  });
}
