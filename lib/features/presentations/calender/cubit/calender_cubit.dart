import 'package:baby_tracker_app/features/data/datasources/local/diaper_change_local_datasource.dart';
import 'package:baby_tracker_app/features/data/datasources/local/feeding_local_datasource.dart';
import 'package:baby_tracker_app/features/data/datasources/local/sleep_local_datasource.dart';
import 'package:baby_tracker_app/features/data/models/diaper_change_model.dart';
import 'package:baby_tracker_app/features/data/models/feeding_model.dart';
import 'package:baby_tracker_app/features/data/models/sleep_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calender_state.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CalenderCubit({
    required SleepLocalDatasource sleepLocalDatasource,
    required DiaperChangeLocalDatasource diaperChangeLocalDatasource,
    required FeedingLocalDatasource feedingLocalDatasource,
  })  : _diaperChangeLocalDatasource = diaperChangeLocalDatasource,
        _feedingLocalDatasource = feedingLocalDatasource,
        _sleepLocalDatasource = sleepLocalDatasource,
        super(
          const CalenderState(
            status: CalenderStatus.init,
            diaperChanges: [],
            feedings: [],
            sleeps: [],
            all: [],
            tabIndex: 0,
          ),
        ) {
    init();
  }

  final SleepLocalDatasource _sleepLocalDatasource;
  final DiaperChangeLocalDatasource _diaperChangeLocalDatasource;
  final FeedingLocalDatasource _feedingLocalDatasource;

  //for initialize when first opened
  Future<void> init() async {
    emit(state.copyWith(status: CalenderStatus.loading));
    await getSleeps();
    await getDiaperChange();
    await getFeedings();
    allItems();
    emit(state.copyWith(status: CalenderStatus.success));
  }

  /// for change index when tabbar clicked
  void changeIndex(int index) {
    emit(state.copyWith(tabIndex: index));
  }

  /// add on list for all
  void allItems() {
    List all = [];
    all.addAll(state.sleeps);
    all.addAll(state.diaperChanges);
    all.addAll(state.feedings);
    emit(state.copyWith(all: all));
  }

  Future<void> getSleeps() async {
    var result = await _sleepLocalDatasource.getAll();
    if (result.success) {
      var data = result.data;
      data!.sort((a, b) => b.wakeUp!.compareTo(a.wakeUp!));
      emit(state.copyWith(sleeps: data));
    }
  }

  Future<void> getDiaperChange() async {
    var result = await _diaperChangeLocalDatasource.getAll();
    if (result.success) {
      var data = result.data;
      data!.sort((a, b) => b.time!.compareTo(a.time!));
      emit(state.copyWith(diaperChanges: data));
    }
  }

  Future<void> getFeedings() async {
    var result = await _feedingLocalDatasource.getAll();
    if (result.success) {
      var data = result.data;
      data!.sort((a, b) => b.time!.compareTo(a.time!));
      emit(state.copyWith(feedings: data));
    }
  }
}

//Tab chooses
enum TabChoose {
  all,
  feedings,
  diaperChanges,
  sleeps,
}
