import 'package:baby_tracker_app/features/core/utils/result/data_result.dart';
import 'package:baby_tracker_app/features/core/utils/result/result.dart';

import '../../models/onboarding_model.dart';

abstract class OnboardingLocalDatasource {
  Future<Result> create(OnboardingModel model);
  Future<Result> update(OnboardingModel model);
  Future<DataResult<OnboardingModel>> get();
}
