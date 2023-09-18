import 'package:baby_tracker_app/features/data/models/diaper_change_model.dart';
import 'package:baby_tracker_app/features/data/models/feeding_model.dart';
import 'package:baby_tracker_app/features/data/models/onboarding_model.dart';
import 'package:baby_tracker_app/features/data/models/premium_model.dart';
import 'package:baby_tracker_app/features/data/models/sleep_model.dart';
import 'package:hive/hive.dart';

import '../../data/models/baby_model.dart';

late Box<BabyModel> babyBox;
late Box<DiaperChangeModel> diaperChangeBox;
late Box<FeedingModel> feedingBox;
late Box<SleepModel> sleepBox;
late Box<OnboardingModel> onboardingBox;
late Box<PremiumModel> premiumBox;

Future<void> hiveBox() async {
  onboardingBox = await Hive.openBox<OnboardingModel>('onboarding');
  babyBox = await Hive.openBox<BabyModel>('babies');
  feedingBox = await Hive.openBox<FeedingModel>('feedings');
  diaperChangeBox = await Hive.openBox<DiaperChangeModel>('diaperchanges');
  sleepBox = await Hive.openBox<SleepModel>('sleeps');
  premiumBox = await Hive.openBox<PremiumModel>('premium');
}

void hiveRegisterAdapter() {
  Hive.registerAdapter<OnboardingModel>(OnboardingModelAdapter());
  Hive.registerAdapter<BabyModel>(BabyModelAdapter());
  Hive.registerAdapter<FeedingModel>(FeedingModelAdapter());
  Hive.registerAdapter<SleepModel>(SleepModelAdapter());
  Hive.registerAdapter<DiaperChangeModel>(DiaperChangeModelAdapter());
  Hive.registerAdapter<PremiumModel>(PremiumModelAdapter());
}
