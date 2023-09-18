import 'package:baby_tracker_app/features/core/hive/hive_box.dart';
import 'package:baby_tracker_app/features/core/utils/result/data_result.dart';
import 'package:baby_tracker_app/features/core/utils/result/result.dart';
import 'package:baby_tracker_app/features/data/datasources/local/diaper_change_local_datasource.dart';
import 'package:baby_tracker_app/features/data/models/diaper_change_model.dart';

class DiaperChangeLocalDatasourceImpl extends DiaperChangeLocalDatasource {
  @override
  Future<void> clear() async {
    try {
      await diaperChangeBox.clear();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Result> create(DiaperChangeModel model) async {
    try {
      await diaperChangeBox.add(model);
      return Result.success();
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<Result> delete(String id) async {
    try {
      await diaperChangeBox.delete(id);
      return Result.success();
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<DataResult<List<DiaperChangeModel>>> getAll() async {
    try {
      var list = diaperChangeBox.values
          .where((e) => e.time!.day == DateTime.now().day)
          .toList();
      return DataResult<List<DiaperChangeModel>>.success("Success", data: list);
    } catch (e) {
      return DataResult<List<DiaperChangeModel>>.fail(e.toString());
    }
  }

  @override
  Future<Result> update(DiaperChangeModel model) async {
    try {
      await diaperChangeBox.put(model.id, model);
      return Result.success();
    } catch (e) {
      return Result.fail(e.toString());
    }
  }
}
