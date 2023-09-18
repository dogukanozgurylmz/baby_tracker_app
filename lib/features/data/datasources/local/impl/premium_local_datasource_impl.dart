import 'package:baby_tracker_app/features/core/hive/hive_box.dart';
import 'package:baby_tracker_app/features/core/utils/result/data_result.dart';
import 'package:baby_tracker_app/features/core/utils/result/result.dart';
import 'package:baby_tracker_app/features/data/datasources/local/premium_local_datasource.dart';
import 'package:baby_tracker_app/features/data/models/premium_model.dart';

class PremiumLocalDatasourceImpl extends PremiumLocalDatasource {
  @override
  Future<Result> create(PremiumModel model) async {
    try {
      await premiumBox.add(model);
      return Result.success();
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<DataResult<PremiumModel>> get() async {
    try {
      var result = premiumBox.values.first;
      return DataResult<PremiumModel>.success("Success", data: result);
    } catch (e) {
      return DataResult<PremiumModel>.fail(e.toString());
    }
  }

  @override
  Future<Result> update(PremiumModel model) async {
    try {
      await premiumBox.put(0, model);
      return Result.success();
    } catch (e) {
      return Result.fail(e.toString());
    }
  }
}
