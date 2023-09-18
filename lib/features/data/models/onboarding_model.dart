import 'package:hive/hive.dart';
part 'onboarding_model.g.dart';

@HiveType(typeId: 2)
class OnboardingModel {
  @HiveField(0)
  bool? isSee;

  OnboardingModel({
    required this.isSee,
  });
}
