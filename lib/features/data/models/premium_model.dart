import 'package:hive/hive.dart';

part 'premium_model.g.dart';

@HiveType(typeId: 6)
class PremiumModel {
  @HiveField(0)
  bool? isPremium;

  PremiumModel({
    required this.isPremium,
  });
}
