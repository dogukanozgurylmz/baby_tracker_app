import 'package:baby_tracker_app/features/core/hive/hive_box.dart';
import 'package:baby_tracker_app/features/core/utils/result/data_result.dart';
import 'package:baby_tracker_app/features/core/utils/result/result.dart';
import 'package:baby_tracker_app/features/data/models/sleep_model.dart';

abstract class SleepLocalDatasource {
  Future<Result> create(SleepModel model);
  Future<void> clear();
  Future<DataResult<List<SleepModel>>> getAll();
  Future<Result> delete(String id);
  Future<Result> update(SleepModel model);
}

Future<void> create(SleepModel model) async {
  try {
    await sleepBox.add(model);
  } catch (e) {
    print(e);
  }
}

Future<void> clear() async {
  try {
    await sleepBox.clear();
  } catch (e) {
    print(e);
  }
}

Future<List<SleepModel>> getAll() async {
  try {
    var list = sleepBox.values
        .where((e) => e.wakeUp!.day == DateTime.now().day)
        .toList();
    return list;
  } catch (e) {
    throw Exception(e);
  }
}

Future<void> delete(String id) async {
  try {
    await sleepBox.delete(id);
  } catch (e) {
    //
  }
}

Future<void> update(SleepModel model) async {
  await sleepBox.put(model.id, model);
}
