import 'package:baby_tracker_app/features/core/utils/result/data_result.dart';
import 'package:baby_tracker_app/features/core/utils/result/result.dart';
import 'package:baby_tracker_app/features/data/models/feeding_model.dart';

abstract class FeedingLocalDatasource {
  Future<Result> create(FeedingModel model);
  Future<void> clear();
  Future<DataResult<List<FeedingModel>>> getAll();
  Future<Result> delete(String id);
  Future<Result> update(FeedingModel model);
}
