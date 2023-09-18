import 'package:baby_tracker_app/features/core/utils/result/data_result.dart';
import 'package:baby_tracker_app/features/core/utils/result/result.dart';
import 'package:baby_tracker_app/features/data/datasources/local/baby_local_datasource.dart';
import 'package:baby_tracker_app/features/data/models/baby_model.dart';

import '../../../../core/hive/hive_box.dart';

class BabyLocalDatasourceImpl extends BabyLocalDatasource {
  @override
  Future<Result> create(BabyModel model) async {
    try {
      await babyBox.add(model);
      return Result.success("Baby created successfully");
    } catch (e) {
      return Result.fail("Not found $e");
    }
  }

  @override
  Future<void> clear() async {
    try {
      await babyBox.clear();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Result> delete(String id) async {
    try {
      await babyBox.delete(id);
      return Result.success();
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<DataResult<List<BabyModel>>> getAll() async {
    try {
      var list = babyBox.values.toList();
      return DataResult<List<BabyModel>>.success("Success", data: list);
    } catch (e) {
      return DataResult<List<BabyModel>>.fail(e.toString());
    }
  }

  @override
  Future<DataResult<BabyModel?>> getBaby() async {
    try {
      var result = babyBox.getAt(0);
      return DataResult<BabyModel?>.success("Success", data: result);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Result> update(BabyModel model) async {
    try {
      await babyBox.putAt(0, model);
      return Result.success();
    } catch (e) {
      return Result.fail("Not found $e");
    }
  }
}
