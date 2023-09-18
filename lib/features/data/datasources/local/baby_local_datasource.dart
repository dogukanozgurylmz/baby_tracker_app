import 'package:baby_tracker_app/features/core/utils/result/data_result.dart';
import 'package:baby_tracker_app/features/core/utils/result/result.dart';
import 'package:baby_tracker_app/features/data/models/baby_model.dart';

abstract class BabyLocalDatasource {
  Future<Result> create(BabyModel model);
  Future<void> clear();
  Future<DataResult<List<BabyModel>>> getAll();
  Future<Result> delete(String id);
  Future<DataResult<BabyModel?>> getBaby();
  Future<Result> update(BabyModel model);
}
