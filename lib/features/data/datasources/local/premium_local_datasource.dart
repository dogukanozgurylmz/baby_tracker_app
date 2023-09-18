import 'package:baby_tracker_app/features/core/utils/result/data_result.dart';
import 'package:baby_tracker_app/features/core/utils/result/result.dart';
import 'package:baby_tracker_app/features/data/models/premium_model.dart';

abstract class PremiumLocalDatasource {
  Future<Result> create(PremiumModel model);
  Future<Result> update(PremiumModel model);
  Future<DataResult<PremiumModel>> get();
}
