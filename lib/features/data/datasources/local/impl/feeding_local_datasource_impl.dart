import 'package:baby_tracker_app/features/core/hive/hive_box.dart';
import 'package:baby_tracker_app/features/core/utils/result/data_result.dart';
import 'package:baby_tracker_app/features/core/utils/result/result.dart';
import 'package:baby_tracker_app/features/data/datasources/local/feeding_local_datasource.dart';
import 'package:baby_tracker_app/features/data/models/feeding_model.dart';

class FeedingLocalDatasourceImpl extends FeedingLocalDatasource {
  @override
  Future<void> clear() async {
    try {
      await feedingBox.clear();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Result> create(FeedingModel model) async {
    try {
      await feedingBox.add(model);
      return Result.success();
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<Result> delete(String id) async {
    try {
      await feedingBox.delete(id);
      return Result.success();
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<DataResult<List<FeedingModel>>> getAll() async {
    try {
      var list = feedingBox.values
          .where((e) => e.time!.day == DateTime.now().day)
          .toList();
      return DataResult<List<FeedingModel>>.success("Success", data: list);
    } catch (e) {
      return DataResult<List<FeedingModel>>.fail(e.toString());
    }
  }

  @override
  Future<Result> update(FeedingModel model) async {
    try {
      await feedingBox.put(model.id, model);
      return Result.success();
    } catch (e) {
      return Result.fail(e.toString());
    }
  }
}
