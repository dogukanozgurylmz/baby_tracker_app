import 'package:baby_tracker_app/features/core/hive/hive_box.dart';
import 'package:baby_tracker_app/features/core/utils/result/data_result.dart';
import 'package:baby_tracker_app/features/core/utils/result/result.dart';
import 'package:baby_tracker_app/features/data/datasources/local/onboarding_local_datasource.dart';
import 'package:baby_tracker_app/features/data/models/onboarding_model.dart';

class OnboardingLocalDatasourceImpl extends OnboardingLocalDatasource {
  @override
  Future<Result> create(OnboardingModel model) async {
    try {
      await onboardingBox.add(model);
      return Result.success();
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<DataResult<OnboardingModel>> get() async {
    try {
      var result = onboardingBox.values.first;
      return DataResult<OnboardingModel>.success("Success", data: result);
    } catch (e) {
      return DataResult<OnboardingModel>.fail(e.toString());
    }
  }

  @override
  Future<Result> update(OnboardingModel model) async {
    try {
      await onboardingBox.put(0, model);
      return Result.success();
    } catch (e) {
      return Result.fail(e.toString());
    }
  }
}
