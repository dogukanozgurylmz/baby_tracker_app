import 'package:baby_tracker_app/features/core/hive/hive_box.dart';
import 'package:baby_tracker_app/features/core/utils/result/data_result.dart';
import 'package:baby_tracker_app/features/core/utils/result/result.dart';
import 'package:baby_tracker_app/features/data/datasources/local/sleep_local_datasource.dart';
import 'package:baby_tracker_app/features/data/models/sleep_model.dart';

class SleepLocalDatasourceImpl extends SleepLocalDatasource {
  @override
  Future<void> clear() async {
    try {
      await sleepBox.clear();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Result> create(SleepModel model) async {
    try {
      await sleepBox.add(model);
      return Result.success();
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<Result> delete(String id) async {
    try {
      await sleepBox.delete(id);
      return Result.success();
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<DataResult<List<SleepModel>>> getAll() async {
    try {
      var list = sleepBox.values
          .where((e) => e.wakeUp!.day == DateTime.now().day)
          .toList();
      return DataResult<List<SleepModel>>.success("Success", data: list);
    } catch (e) {
      return DataResult<List<SleepModel>>.fail(e.toString());
    }
  }

  @override
  Future<Result> update(SleepModel model) async {
    try {
      await sleepBox.put(model.id, model);
      return Result.success();
    } catch (e) {
      return Result.fail(e.toString());
    }
  }
}
