import 'package:baby_tracker_app/features/core/utils/result/data_result.dart';
import 'package:baby_tracker_app/features/core/utils/result/result.dart';
import 'package:baby_tracker_app/features/data/models/diaper_change_model.dart';

abstract class DiaperChangeLocalDatasource {
  Future<Result> create(DiaperChangeModel model);
  Future<void> clear();
  Future<DataResult<List<DiaperChangeModel>>> getAll();
  Future<Result> delete(String id);
  Future<Result> update(DiaperChangeModel model);
}
